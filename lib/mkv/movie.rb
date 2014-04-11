require 'time'

module MKV
  class Movie
    @@timeout = 200

    attr_reader :path

    def initialize(path)
      raise Errno::ENOENT, "the file '#{path}' does not exist" unless File.exists?(path)

      @path = path
      MKV.logger.info(command)
    end

    def tracks
      @tracks ||= parse.map do |track_data|
        constantize(track_data[:track_type]).new(track_data)
      end
    end

    def invalid?
      @invalid = true unless tracks.any?
      @invalid = true if output.include?("is not supported")
      @invalid = true if output.include?("could not find codec parameters")
    end

    def valid?
      not invalid?
    end

    def has_video?
      tracks.video.any?
    end

    def has_audio?
      tracks.audio.any?
    end

    def has_subtitles?
      tracks.subtitles.any?
    end

    def extract_subtitles(options={})
      track_filter = track_filter(options[:language] || [])

      options[:language] ||= []
      options[:language] = [options[:language]].flatten.map(&:to_sym) if options[:language]
      options[:language] << :und if options[:language].any?

      track_filter = lambda { |t| t.type == 'subtitles' && (options[:language].include?(t.language.to_sym) || options[:language].empty?) }

      tracks.select(&track_filter).each do |track|
        destination_fileextension = (options[:language].count == 1 ? "" : ".#{track.mkv_info_id}.#{track.language}") + ".srt"
        destination_filename = File.basename(@path).gsub(/\.mkv$/i, destination_fileextension)
        destination_dir = options[:destination_dir] || File.dirname(@path)

        command = %Q[#{MKV.mkvextract_binary} tracks "#{@path}" #{track.mkv_info_id}:"#{File.join(destination_dir, destination_filename)}"]
        MKV.logger.info(command)

        output = ""
        start_time = Time.now.to_i
        begin
          Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
            yield(0.0, 0, destination_filename) if block_given?
            next_line = Proc.new do |line|
              output << line
              if line =~ /(\d+)%/
                progress = $1.to_i

                yield(progress, Time.now.to_i - start_time, destination_filename) if block_given?
              end

              if line =~ /Unsupported codec/
                MKV.logger.error "Failed encoding...\nCommand\n#{command}\nOutput\n#{output}\n"
                raise "Failed encoding: #{line}"
              end
            end

            if @@timeout
              stdout.each_with_timeout(wait_thr.pid, @@timeout, "r", &next_line)
            else
              stdout.each("r", &next_line)
            end
          end
        rescue Timeout::Error => e
          MKV.logger.error "Process hung...\nCommand\n#{command}\nOutput\n#{output}\n"
          raise MKV::Error, "Process hung. Full output: #{output}"
        end
      end
    end

    private

    def parse
      output.split("| + A track")[1..-1].each.map { |track|
        a3 = track.scan(/\|\s+\+\s+([^\:|^\n]+):\s([^\n[\s(])]+)/)
        Hash[a3.map {|key, value| [key.downcase.gsub(' ', '_').to_sym, value]}]
      }
    end

    def output
      @output ||= Open3.popen2(command) { |stdin, stdout| stdout.read }
    end

    def command
      "#{MKV.mkvinfo_binary} #{Shellwords.escape(path)}"
    end

    def constantize(type)
      Module.const_get("MKV::#{type.capitalize}Track")
    rescue
      MKV::Track
    end
  end
end

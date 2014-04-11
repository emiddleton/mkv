module MKV
  class SubtitlesTrack < Track
    attr_reader :language, :enabled, :default, :forced

    def initialize(data)
      super(data)
      @language = data.fetch(:language).to_sym
      @enabled = data.fetch(:enabled)
      @default = data.fetch(:default_flag) != '0'
      @forced = data.fetch(:forced_flag) != '0'
    end
    def extract!(path, options={})
      options[:language] ||= []

      destination_fileextension = (options[:language].count == 1 ? "" : ".#{mkv_info_id}.#{language}") + ".srt"

      destination_filename = File.basename(path).gsub(/\.mkv$/i, destination_fileextension)
      destination_dir = options[:destination_dir] || File.dirname(path)

      command = %Q[#{MKV.mkvextract_binary} tracks "#{path}" #{mkv_info_id}:"#{File.join(destination_dir, destination_filename)}"]
      MKV.logger.info(command)

      output = ""
      start_time = Time.now.to_i
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

        stdout.each_with_timeout(wait_thr.pid, 200, "r", &next_line)
      end
    rescue Timeout::Error
      MKV.logger.error "Process hung...\nCommand\n#{command}\nOutput\n#{output}\n"
      raise MKV::Error, "Process hung. Full output: #{output}"
    end
  end
end

module MKV
  class SubtitlesTrack < Track
    attr_reader :language, :enabled, :default, :forced

    def initialize(data)
      super(data)
      @language = data.fetch(:language).to_sym
      @enabled = data.fetch(:enabled)
    end

    def extract!(path, destination = nil)
      destination_file = destination(path, destination)

      command = %Q[#{MKV.mkvextract_binary} tracks "#{path}" #{mkv_info_id}:"#{destination_file}"]

      MKV.logger.info(command)
      start_time = Time.now.to_i
      output = ''
      Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
        yield(0.0, 0, destination_filename) if block_given?
        next_line = next_line(line, filename, start_time, output)
        stdout.each_with_timeout(wait_thr.pid, 200, "r", &next_line)
      end
    rescue Timeout::Error
        MKV.logger.error "Process hung...\nCommand\n#{command}\nOutput\n#{output}\n"
      raise MKV::Error, "Process hung. Full output: #{output}"
    end

    private

    def next_line(line, filename, start_time, output)
      if line =~ /(\d+)%/
        progress = $1.to_i
        yield(progress, Time.now.to_i - start_time, filename) if block_given?
      end
      if line =~ /Unsupported codec/
        MKV.logger.error "Failed encoding...\nCommand\n#{command}\nOutput\n#{output}\n"
        raise "Failed encoding: #{line}"
      end
    end

    def filename(path)
      extension = ".#{mkv_info_id}.#{language}.srt"
      File.basename(path).gsub(/\.mkv$/i, extension)
    end

    def destination(path, destination = nil)
      filename = filename(path)
      destination = destination || File.dirname(path)
      File.join(destination, filename)
    end
  end
end

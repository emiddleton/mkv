module MKV
  class VideoSplitter
    attr_reader :path, :chapter_ids

    def initialize(path, chapter_ids = [])
      @path = path
      @chapter_ids = chapter_ids
    end

    def split
      Open3.popen2(command) { |_, stdout| stdout.read }
    end

    private

    def formatted_ids
      if chapter_ids.empty?
        'all'
      else
        chapter_ids.join(',')
      end
    end

    def command
      "#{MKV.mkvmerge_binary} #{path} --split chapters:#{formatted_ids} -o #{new_path}"
    end

    def new_path
      path.gsub(".mkv", ".episode%d.mkv")
    end
  end
end

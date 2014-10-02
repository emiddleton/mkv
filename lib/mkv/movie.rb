module MKV
  class Movie
    @@timeout = 200

    attr_reader :path

    def initialize(path)
      unless File.exists?(path)
        raise Errno::ENOENT, "the file '#{path}' does not exist"
      end

      @path = path
      MKV.logger.info(command)
    end

    def tracks
      @tracks ||= MKV::Tracks.new(get_tracks)
    end

    def chapters
      @chapters ||= MKV::Chapters.new(get_chapters)
    end

    def invalid?
      not valid?
    end

    def valid?
      @tracks.valid?
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

      tracks.subtitles.select(&track_filter).each do |track|
        track.extract!(@path, options[:destination_dir])
      end
    end

    def duration
      parser.duration.to_i
    end

    def episodes
      chapters.episodes
    end

    def split_by_episode
      chapter_ids = episodes.map do |episode|
        chapters.offset_index(episode.first)
      end
      chapters.split!(path, chapter_ids)
    end

    private

    def parser
      @parser ||= MKV::Parser.new(output)
    end

    def output
      @output ||= Open3.popen2(command) { |stdin, stdout| stdout.read }
    end

    def command
      "#{MKV.mkvinfo_binary} #{Shellwords.escape(path)}"
    end

   def get_tracks
      parser.titles.map do |track_data|
        MKV::TrackFactory.for(track_data[:track_type]).new(track_data)
      end
    end

    def get_chapters

      parser.chapters.map do |chapter|
        MKV::Chapter.new(chapter)
      end
    end

    def track_filter(language)
      lambda { |t| language.include?(t.language) || language.empty? }
    end
  end
end

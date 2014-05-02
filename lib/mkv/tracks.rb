module MKV
  class Tracks
    include Enumerable

    def initialize(tracks)
      @tracks = tracks
    end

    def each(&block)
      @tracks.each(&block)
    end

    def subtitles
      select { |track| track.instance_of? SubtitlesTrack }
    end

    def video
      select { |track| track.instance_of? VideoTrack }
    end

    def audio
      select { |track| track.instance_of? AudioTrack }
    end

    def last
      to_a.last
    end

    def valid?
      any?
    end
  end
end

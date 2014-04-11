module MKV
  class Tracks < Array
    def subtitles
      select { |track| track.instance_of? SubtitlesTrack }
    end

    def video
      select { |track| track.instance_of? VideoTrack }
    end

    def audio
      select { |track| track.instance_of? AudioTrack }
    end

    def valid?
      any?
    end
  end
end

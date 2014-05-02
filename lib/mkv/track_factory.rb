module MKV
  module TrackFactory
    TRACK_CLASS = {
      'audio' => MKV::AudioTrack,
      'subtitles' => MKV::SubtitlesTrack,
      'video' => MKV::VideoTrack
    }
    def self.for(type = nil)
      TRACK_CLASS[type] || MKV::Track
    end
  end
end

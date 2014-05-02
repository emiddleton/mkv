require 'spec_helper'

describe MKV::TrackFactory do
  describe '.for' do
    it 'returns a video track' do
      expect(MKV::TrackFactory.for('video')).to eq MKV::VideoTrack
    end

    it 'returns a audio track' do
      expect(MKV::TrackFactory.for('audio')).to eq MKV::AudioTrack
    end

    it 'returns a subtitles track' do
      expect(MKV::TrackFactory.for('subtitles')).to eq MKV::SubtitlesTrack
    end

    it 'returns a default track' do
      expect(MKV::TrackFactory.for()).to eq MKV::Track
    end
  end
end

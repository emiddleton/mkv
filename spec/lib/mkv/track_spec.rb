require 'spec_helper'

describe MKV::Track do
  describe '#type' do
    it 'returns the type' do
      expect(video_track.type).to eq 'video'
    end
  end

  describe '#uid' do
    it 'returns the uid' do
      expect(video_track.uid).to eq '2395334065'
    end
  end

  describe '#number' do
    it 'returns the number' do
      expect(video_track.number).to eq 1
    end
  end

  describe '#mkv_info_id' do
    it 'returns the mkv_info_id' do
      expect(video_track.mkv_info_id).to eq 0
    end
  end

  describe '#lacing' do
    it 'returns the lacing' do
      expect(video_track.lacing).to be_false
    end
  end

  describe '#codec_id' do
    it 'returns the codec_id' do
      expect(video_track.codec_id).to eq 'V_MPEG4/ISO/AVC'
    end
  end

  def video_track
    MKV::Track.new(video_track_attributes)
  end

  def video_track_attributes
    {
      codec_id: 'V_MPEG4/ISO/AVC',
      lacing_flag: '0',
      track_number: '1',
      track_type: 'video',
      track_uid: '2395334065'
    }
  end
end

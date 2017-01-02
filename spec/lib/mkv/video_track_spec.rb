require 'spec_helper'

describe MKV::VideoTrack do

  describe '#type' do
    it 'returns the type' do
      expect(video_track.type).to eq 'video'
    end
  end

  describe '#width' do
    it 'returns the width' do
      expect(video_track.width).to eq 848
    end
  end

  describe '#height' do
    it 'returns the height' do
      expect(video_track.height).to eq 360
    end
  end

  def video_track
    MKV::VideoTrack.new(video_track_attributes)
  end

  def video_track_attributes
    {
      codec_id: 'V_MPEG4/ISO/AVC',
      lacing_flag: '0',
      pixel_height: '360',
      pixel_width: '848',
      track_number: '1',
      track_id: '0',
      track_type: 'video',
      track_type: 'video',
      track_uid: '2395334065'
    }
  end
end

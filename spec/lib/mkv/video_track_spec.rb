require 'spec_helper'

VIDEO_TRACK = {pixel_width: '848', pixel_height: '360', track_type: 'video', track_type: 'video', track_uid: '2395334065', track_number: '1', lacing_flag: '0', codec_id: 'V_MPEG4/ISO/AVC'}

describe MKV::VideoTrack, '#type' do
  it 'returns the type' do
    expect(video_track.type).to eq 'video'
  end
end

describe MKV::VideoTrack, '#width' do
  it 'returns the width' do
    expect(video_track.width).to eq 848
  end
end

describe MKV::VideoTrack, '#height' do
  it 'returns the height' do
    expect(video_track.height).to eq 360
  end
end

def video_track
  MKV::VideoTrack.new(VIDEO_TRACK)
end

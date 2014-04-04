require 'spec_helper'

VIDEO_TRACK = {track_type: 'video', track_uid: '2395334065', track_number: '1', lacing_flag: '0', codec_id: 'V_MPEG4/ISO/AVC'}

describe MKV::Track, '#type' do
  it 'returns the type' do
    expect(video_track.type).to eq 'video'
  end
end

describe MKV::Track, '#uid' do
  it 'returns the uid' do
    expect(video_track.uid).to eq '2395334065'
  end
end

describe MKV::Track, '#number' do
  it 'returns the number' do
    expect(video_track.number).to eq 1
  end
end

describe MKV::Track, '#mkv_info_id' do
  it 'returns the mkv_info_id' do
    expect(video_track.mkv_info_id).to eq 0
  end
end

describe MKV::Track, '#lacing' do
  it 'returns the lacing' do
    expect(video_track.lacing).to be_false
  end
end

describe MKV::Track, '#codec_id' do
  it 'returns the codec_id' do
    expect(video_track.codec_id).to eq 'V_MPEG4/ISO/AVC'
  end
end

def video_track
  MKV::Track.new(VIDEO_TRACK)
end

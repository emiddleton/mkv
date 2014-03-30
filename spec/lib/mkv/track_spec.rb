require 'spec_helper'

VIDEO_TRACK = "\n|  + Track number: 1 (track ID for mkvmerge & mkvextract: 0)\n|  + Track UID: 2395334065\n|  + Track type: video\n|  + Enabled: 1\n|  + Default flag: 1\n|  + Forced flag: 0\n|  + Lacing flag: 0\n|  + MinCache: 1\n|  + Timecode scale: 1\n|  + Max BlockAddition ID: 0\n|  + Codec ID: V_MPEG4/ISO/AVC\n|  + Codec decode all: 1\n|  + CodecPrivate, length 43 (h.264 profile: High @L4.0)\n|  + Default duration: 41.667ms (24.000 frames/fields per second for a video track)\n|  + Language: eng\n|  + Name: Main title\n|  + Video track\n|   + Pixel width: 848\n|   + Pixel height: 360\n|   + Interlaced: 0\n|   + Display width: 848\n|   + Display height: 360\n"

AUDIO_TRACK =  "\n|  + Track number: 2 (track ID for mkvmerge & mkvextract: 1)\n|  + Track UID: 3490362511\n|  + Track type: audio\n|  + Enabled: 1\n|  + Default flag: 0\n|  + Forced flag: 0\n|  + Lacing flag: 1\n|  + MinCache: 0\n|  + Timecode scale: 1\n|  + Max BlockAddition ID: 0\n|  + Codec ID: A_AAC\n|  + Codec decode all: 1\n|  + CodecPrivate, length 5\n|  + Default duration: 21.333ms (46.875 frames/fields per second for a video track)\n|  + Language: eng\n|  + Name: English Stereo\n|  + Audio track\n|   + Sampling frequency: 48000\n|   + Channels: 2\n"

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
    expect(video_track.number).to eq '1'
  end
end

describe MKV::Track, '#mkv_info_id' do
  it 'returns the mkv_info_id' do
    expect(video_track.mkv_info_id).to eq '0'
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

describe MKV::Track, '#width' do
  it 'returns the width' do
    expect(video_track.width).to eq 848
  end
end

describe MKV::Track, '#height' do
  it 'returns the height' do
    expect(video_track.height).to eq 360
  end
end

describe MKV::Track, '#sampling_frequency' do
  it 'returns the sampling_frequency' do
    expect(audio_track.sampling_frequency).to eq 48000
  end
end

describe MKV::Track, '#channels' do
  it 'returns the channels' do
    expect(audio_track.channels).to eq 2
  end
end

describe MKV::Track, '#language' do
  it 'returns the language' do
    expect(audio_track.language).to eq 'eng'
  end
end

describe MKV::Track, '#enabled' do
  it 'returns the enabled' do
    expect(video_track.enabled).to be_nil
  end
end

describe MKV::Track, '#default' do
  it 'returns the default' do
    expect(video_track.default).to be_nil
  end
end

describe MKV::Track, '#forced' do
  it 'returns the forced' do
    expect(video_track.forced).to be_nil
  end
end

def video_track
  MKV::Track.new(VIDEO_TRACK)
end

def audio_track
  MKV::Track.new(AUDIO_TRACK)
end

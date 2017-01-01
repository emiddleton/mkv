require 'spec_helper'

AUDIO_TRACK =  {track_type: 'audio', codec_id: 'A_AAC', sampling_frequency: '48000', channels: '6', name: 'Surround 5.1', language: 'eng', track_number: '4', track_uid: '1231234', lacing_flag: '0', language: 'eng', enabled: '0', default_flag: '0', forced_flag: '0' }

describe MKV::AudioTrack, '#type' do
  it 'returns the type' do
    expect(audio_track.type).to eq 'audio'
  end
end

describe MKV::AudioTrack, '#codec_id' do
  it 'returns the codec_id' do
    expect(audio_track.codec_id).to eq 'A_AAC'
  end
end

describe MKV::AudioTrack, '#sampling_frequency' do
  it 'returns the sampling_frequency' do
    expect(audio_track.sampling_frequency).to eq 48000
  end
end

describe MKV::AudioTrack, '#channels' do
  it 'returns the channels' do
    expect(audio_track.channels).to eq 6
  end
end

describe MKV::AudioTrack, '#name' do
  it 'returns the name' do
    expect(audio_track.name).to eq 'Surround 5.1'
  end
end

describe MKV::AudioTrack, '#language' do
  it 'returns the language' do
    expect(audio_track.language).to eq 'eng'
  end
end

def audio_track
  MKV::AudioTrack.new(AUDIO_TRACK)
end

require 'spec_helper'

SUBTITLES_TRACK =  {track_type: 'subtitles', codec_id: 'A_AAC', sampling_frequency: '48000', channels: '2', language: 'eng', track_number: '4', track_uid: '1231234', lacing_flag: '0', language: 'eng', enabled: '0', default_flag: '0', forced_flag: '0' }

describe MKV::SubtitlesTrack, '#type' do
  it 'returns the type' do
    expect(subtitles_track.type).to eq 'subtitles'
  end
end

describe MKV::SubtitlesTrack, '#language' do
  it 'returns the language' do
    expect(subtitles_track.language).to eq 'eng'
  end
end

def subtitles_track
  MKV::SubtitlesTrack.new(SUBTITLES_TRACK)
end

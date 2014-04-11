require 'spec_helper'

TRACK =  {track_type: 'audio', codec_id: 'A_AAC', sampling_frequency: '48000', channels: '2', language: 'eng', track_number: '4', track_uid: '1231234', lacing_flag: '0', language: 'eng', enabled: '0', default_flag: '0', forced_flag: '0', pixel_width: 123, pixel_height: '1235' }


describe MKV::Tracks, '#subtitles' do
  it 'gets all of the subtitle tracks' do
    audio_track = MKV::AudioTrack.new(TRACK)
    subtitles_track = MKV::SubtitlesTrack.new(TRACK)

    tracks = MKV::Tracks.new([audio_track, subtitles_track])

    expect(tracks.subtitles).to eq [subtitles_track]
  end
end

describe MKV::Tracks, '#audio' do
  it 'gets all of the subtitle tracks' do
    audio_track = MKV::AudioTrack.new(TRACK)
    subtitles_track = MKV::SubtitlesTrack.new(TRACK)

    tracks = MKV::Tracks.new([audio_track, subtitles_track])

    expect(tracks.audio).to eq [audio_track]
  end
end

describe MKV::Tracks, '#video' do
  it 'gets all of the subtitle tracks' do
    audio_track = MKV::AudioTrack.new(TRACK)
    video_track = MKV::VideoTrack.new(TRACK)

    tracks = MKV::Tracks.new([audio_track, video_track])

    expect(tracks.video).to eq [video_track]
  end
end

describe MKV::Tracks, '#valid?' do
  it 'valid when there are tracks' do
    tracks = MKV::Tracks.new([double('track')])

    expect(tracks).to be_valid
  end
end

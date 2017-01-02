require 'spec_helper'

SUBTITLES_TRACK =  { track_type: 'subtitles', codec_id: 'A_AAC', sampling_frequency: '48000', channels: '2', language: 'eng', track_number: '4', track_id: '3', track_uid: '1231234', lacing_flag: '0', language: 'eng', enabled: '0' }

describe MKV::SubtitlesTrack, '#type' do
  it 'returns the type' do
    expect(subtitles_track.type).to eq 'subtitles'
  end
end

describe MKV::SubtitlesTrack, '#language' do
  it 'returns the language' do
    expect(subtitles_track.language).to eq :eng
  end
end

describe MKV::Track, '#extract!' do
  it 'extracts the track' do
    path = '/blahblah.mkv'
    track = subtitles_track
    filepath = '/blahblah.3.eng.srt'

    allow(Open3).to receive(:popen3)
    track.extract!(path)
    expect(Open3).to have_received(:popen3)
      .with("#{MKV.mkvextract_binary} tracks \"#{path}\" #{track.mkv_info_id}:\"#{filepath}\"")
  end

  it 'Logs an error on time' do
    path = '/blahblah.mkv'
    track = subtitles_track

    Open3.stub(:popen3).and_raise(Timeout::Error)
    expect { track.extract!(path) }
      .to raise_error(MKV::Error)
  end

  it 'extracts into a specific destination' do
    path = '/home/user/movies/a_movie.mkv'
    track = subtitles_track
    destination = '/'
    filepath = '/a_movie.3.eng.srt'

    allow(Open3).to receive(:popen3)
    track.extract!(path, destination)
    expect(Open3).to have_received(:popen3)
      .with("#{MKV.mkvextract_binary} tracks \"#{path}\" #{track.mkv_info_id}:\"#{filepath}\"")
  end
end

def subtitles_track
  MKV::SubtitlesTrack.new(SUBTITLES_TRACK)
end

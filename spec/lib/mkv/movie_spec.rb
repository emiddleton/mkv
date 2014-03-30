require 'spec_helper'

describe MKV::Movie, '#new' do
  it 'stops if file does not exist' do
    expect { MKV::Movie.new('my_foo.mkv') }
      .to raise_error(Errno::ENOENT)
  end

  it 'assigns the path accordingly' do
    path  = '/home/eric/Downloads/my_foo.mkv'
    movie = MKV::Movie.new path
    expect(movie.path).to eq path
  end

  it 'assigns tracks to the movie' do
    path  = '/home/eric/Downloads/my_foo.mkv'
    movie = MKV::Movie.new path
    expect(movie.tracks.first).to be_a MKV::Track
  end
end

describe MKV::Movie, '#has_video?' do
  it 'tells us when we have videos' do
    path = '/home/eric/Downloads/my_foo.mkv'
    movie = MKV::Movie.new path
    expect(movie).to have_video
  end
end

describe MKV::Movie, '#has_audio?' do
  it 'tells us when we have audios' do
    path = '/home/eric/Downloads/my_foo.mkv'
    movie = MKV::Movie.new path
    expect(movie).to have_audio
  end
end

describe MKV::Movie, '#extract_subtitles' do
  it 'uses mkvextract to grab subtitles' do
    movie = MKV::Movie.new(path)
    expect(Open3).to receive(:popen3)
      .with("mkvextract tracks \"#{path}\" 2:\"#{destination}/my_foo.2.eng.srt\"").once
    expect(Open3).to receive(:popen3)
      .with("mkvextract tracks \"#{path}\" 3:\"#{destination}/my_foo.3.fre.srt\"").once
    movie.extract_subtitles
  end

  it 'only extracts one language' do
    movie = MKV::Movie.new(path)
    expect(Open3).to_not receive(:popen3)
      .with("mkvextract tracks \"#{path}\" 2:\"#{destination}/my_foo.2.eng.srt\"")
    expect(Open3).to receive(:popen3)
      .with("mkvextract tracks \"#{path}\" 3:\"#{destination}/my_foo.3.fre.srt\"")
    movie.extract_subtitles(language: [:fre])
  end

  it 'specifies a destination' do
    movie = MKV::Movie.new(path)
    expect(Open3).to receive(:popen3)
      .with("mkvextract tracks \"#{path}\" 2:\"/new_destination/my_foo.2.eng.srt\"")
    expect(Open3).to receive(:popen3)
      .with("mkvextract tracks \"#{path}\" 3:\"/new_destination/my_foo.3.fre.srt\"")
    movie.extract_subtitles(destination_dir: "/new_destination/")
  end

  it 'Logs an error on time' do
    movie = MKV::Movie.new(path)
    Open3.stub(:popen3).and_raise(Timeout::Error)
    expect { movie.extract_subtitles }
      .to raise_error(MKV::Error)
  end

  def path
    '/home/eric/Downloads/my_foo.mkv'
  end

  def destination
    File.dirname(path)
  end
end

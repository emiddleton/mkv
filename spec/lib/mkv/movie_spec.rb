require 'spec_helper'

describe MKV::Movie do
  before do
    File.stub(exists?: true)
    Open3.stub(popen2: MKVMock.info)
  end

  describe '#new' do
    it 'stops if file does not exist' do
      File.unstub!(:exists?)
      expect { MKV::Movie.new('my_foo.mkv') }
        .to raise_error(Errno::ENOENT)
    end
  end

  describe '#tracks' do
    it 'assigns tracks to the movie' do
      movie = MKV::Movie.new 'file.mkv'
      expect(movie.tracks.first).to be_a MKV::Track
    end

    it 'gets the tracks for the movie' do
      movie = MKV::Movie.new 'file.mkv'
      expect(movie.tracks.first).to be_a MKV::VideoTrack
      expect(movie.tracks.last).to be_a MKV::SubtitlesTrack
    end

    it 'generates a new generic track when no track is found' do
      movie = MKV::Movie.new 'file.mkv'
      Module.stub(:const_get).and_raise NameError

      expect(movie.tracks.first).to be_a MKV::Track
      expect(movie.tracks.last).to be_a MKV::Track
    end
  end

  describe '#chapters' do
    it 'gets the chapters for the movie' do
      movie = MKV::Movie.new 'file.mkv'
      MKV::Parser.stub(:new).and_return(
        double(MKV::Parser, chapters: [{
          chapter_time_start: 'cool',
          chapter_language: 'eng',
          chapter_uid: '123333'
      }]))
      expect(movie.chapters.first).to be_a MKV::Chapter
    end
  end

  describe '#invalid?' do
    it 'is invalid for trackless movie' do
      pending
      movie = MKV::Movie.new('file.mkv')
      expect(movie).to be_invalid
    end
  end

  describe '#has_video?' do
    it 'tells us when we have videos' do
      movie = MKV::Movie.new 'file.mkv'
      expect(movie).to have_video
    end
  end

  describe '#has_audio?' do
    it 'tells us when we have audios' do
      movie = MKV::Movie.new 'file.mkv'
      expect(movie).to have_audio
    end
  end

  describe '#extract_subtitles' do
    it 'uses mkvextract to grab subtitles' do
      movie = MKV::Movie.new 'file.mkv'
      expect(Open3).to receive(:popen3).twice
      movie.extract_subtitles
    end

    it 'only extracts one language' do
      movie = MKV::Movie.new 'file.mkv'
      expect(Open3).to receive(:popen3).once
      movie.extract_subtitles(language: [:fre])
    end
  end
end

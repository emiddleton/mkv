require 'spec_helper'

describe MKV::Movie do
  describe '#new' do
    it 'stops if file does not exist' do
      expect { MKV::Movie.new('my_foo.mkv') }
        .to raise_error(Errno::ENOENT)
    end

    it 'assigns the path accordingly' do
      expect(movie.path).to eq path
    end
 end

  describe '#tracks' do
    it 'gets the tracks for the movie' do
      MKV::Tracks.stub(:new).and_return('tracks')
      expect(movie.tracks).to eq 'tracks'
    end
  end

  describe '#chapters' do
    it 'gets the chapters for the movie' do
      MKV::Parser.stub(:new).and_return(
        double(MKV::Parser,
          chapters: [{
            chapter_time_start: 'cool',
            chapter_time_end: 'also cool',
            chapter_language: 'eng',
            chapter_uid: '123333'}]
          ))
      expect(movie.chapters.first).to be_a MKV::Chapter
    end
  end

  describe '#has_video?' do
    it 'tells us when we have videos' do
      MKV::Tracks.stub(:new).and_return(double('tracks', video: ['video']))
      expect(movie).to have_video
    end
  end

  describe '#has_audio?' do
    it 'tells us when we have audios' do
      MKV::Tracks.stub(:new).and_return(double('tracks', audio: ['audio']))
      expect(movie).to have_audio
    end
  end

  describe '#extract_subtitles' do
    it 'uses mkvextract to grab subtitles' do
      french = double('french', language: :fre, 'extract!' => true)
      english = double('english', language: :eng, 'extract!' => true)
      MKV::Tracks.stub(:new).and_return(double('tracks', subtitles: [french, english]))
      movie.extract_subtitles
      expect(french).to have_received(:extract!)
      expect(english).to have_received(:extract!)
    end

    it 'only extracts one language' do
      movie.extract_subtitles(language: [:fre])
    end
  end

  def movie
    File.stub(:exists?).and_return true
    MKV::Movie.new(path)
  end

  def path
    'path/to/movie.mkv'
  end

  def destination
    File.dirname(path)
  end
end

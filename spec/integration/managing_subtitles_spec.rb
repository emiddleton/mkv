require 'spec_helper'

describe 'managing subtitles' do
  it 'extracts subtitles track' do
    temporary_fixture('test.mkv') do |dir|
      movie = MKV::Movie.new("#{dir}/test.mkv")

      movie.extract_subtitles
      expect(Dir.entries(dir)).to include('test.4.eng.srt', 'test.5.fre.srt')
    end
  end
end

require 'spec_helper'

describe 'managing chapters' do
  it 'splitting episodes into separate videos' do
    temporary_fixture('test_with_episodes.mkv') do |dir|
      movie = MKV::Movie.new("#{dir}/test_with_episodes.mkv")

      movie.split_by_episode
      expect(Dir.entries(dir)).to include('test_with_episodes.episode1.mkv', 'test_with_episodes.episode2.mkv', 'test_with_episodes.episode3.mkv')
    end
  end
end

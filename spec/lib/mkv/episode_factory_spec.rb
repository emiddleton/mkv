require 'spec_helper'

describe MKV::EpisodeFactory do
  describe '.for' do
    it 'generates some episodes' do
      episode_one = [double('chapter', duration: 10), double('chapter', duration: 1000), double('chapter', duration: 20)]
      episode_two = [double('chapter', duration: 31), double('chapter', duration: 983), double('chapter', duration: 13)]

      episodes = MKV::EpisodeFactory.for(episode_one + episode_two)

      expect(episodes.first).to be_an MKV::Episode
      expect(episodes.first.to_a).to eq episode_one
      expect(episodes.last).to be_an MKV::Episode
      expect(episodes.last.to_a).to eq episode_two
    end
  end
end

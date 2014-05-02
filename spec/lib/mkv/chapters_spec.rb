require 'spec_helper'

describe MKV::Chapters do

  it 'is enumerable' do
    relation = double('relation')
    live_collection = MKV::Chapters.new(relation)

    expect(live_collection).to be_a(Enumerable)
  end

  describe '#episodes' do
    it 'generates episodes from chapters' do
      chapters = MKV::Chapters.new(double('chapters'))

      MKV::EpisodeFactory.stub(:for).and_return('episodes')

      expect(chapters.episodes).to eq 'episodes'
    end
  end
end

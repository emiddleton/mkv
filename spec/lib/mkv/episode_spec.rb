require 'spec_helper'

describe MKV::Episode do
  it 'is enumerable' do
    something = double('something')

    episode = MKV::Episode.new(something)

    expect(episode).to be_a Enumerable
  end
end

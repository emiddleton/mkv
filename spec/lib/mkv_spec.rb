require 'spec_helper'

describe MKV, '.logger' do

end

describe MKV, '.mkvinfo_binary' do
  it 'returns the default location' do
    expect(MKV.mkvinfo_binary).to eq('mkvinfo')
  end

  it 'can be overidden' do
    MKV.mkvinfo_binary = 'fooinfo'
    expect(MKV.mkvinfo_binary).to eq('fooinfo')
    MKV.mkvinfo_binary = nil
  end
end

describe MKV, '.mkvextract_binary' do
  it 'returns the default location' do
    expect(MKV.mkvextract_binary).to eq('mkvextract')
  end

  it 'can be overidden' do
    MKV.mkvextract_binary = 'fooextract'
    expect(MKV.mkvextract_binary).to eq('fooextract')
    MKV.mkvextract_binary = nil
  end
end

require 'spec_helper'

describe MKV do
  describe '.mkvinfo_binary' do
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

  describe MKV, '.mkvmerge_binary' do
    it 'returns the default location' do
      expect(MKV.mkvmerge_binary).to eq('mkvmerge')
    end

    it 'can be overidden' do
      MKV.mkvmerge_binary = 'fooextract'
      expect(MKV.mkvmerge_binary).to eq('fooextract')
      MKV.mkvmerge_binary = nil
    end
  end
end

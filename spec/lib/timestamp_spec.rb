require 'spec_helper'

describe Timestamp do
  describe '#to_seconds' do
    it 'converts the timestamp to seconds' do
      expect(timestamp.to_seconds).to eq 1514
    end
  end

  describe '#to_milliseconds' do
    it 'converts the timestamp to milliseconds string' do
      expect(timestamp.to_milliseconds).to eq '1514867'
    end
  end

  describe '#milliseconds' do
    it 'separates out the milliseconds' do
      expect(timestamp.milliseconds).to eq 867
    end
  end

  describe '#seconds' do
    it 'separates out the seconds' do
      expect(timestamp.seconds).to eq 14
    end
  end

  describe '#minutes' do
    it 'separates out the minutes' do
      expect(timestamp.minutes).to eq 25
    end
  end

  describe '#hours' do
    it 'separates out the hours' do
      expect(timestamp.hours).to eq 0
    end
  end

  def timestamp
    Timestamp.new('00:25:14.8670000')
  end
end

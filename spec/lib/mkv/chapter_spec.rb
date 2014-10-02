require 'spec_helper'

describe MKV::Chapter do
  describe '#start_time' do
    it 'displays start time in seconds' do
      expect(chapter.start_time).to eq 1514.867
    end
  end

  describe '#duration' do
    it 'displays duration in seconds' do
      expect(chapter.duration).to eq 1799.98
    end
  end

  def chapter
    MKV::Chapter.new(chapter_attributes)
  end

  def chapter_attributes
    {
      chapter_time_start: '00:25:14.867000000',
      chapter_time_end: '00:55:14.847000000',
      chapter_language: 'eng',
      chapter_uid: '3903151802'
    }
  end
end

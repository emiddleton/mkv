require 'spec_helper'

describe MKV::Chapter, '#start_time' do
  it 'displays start time in seconds' do
    expect(chapter.start_time).to eq 1514
  end

  def chapter
    MKV::Chapter.new(chapter_attributes)
  end

  def chapter_attributes
    {
      chapter_time_start: '00:25:14.867000000',
      chapter_language: 'eng',
      chapter_uid: '3903151802'
    }
  end
end

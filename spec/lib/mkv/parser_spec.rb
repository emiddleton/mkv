require 'spec_helper'

describe MKV::Parser, '#titles' do
  it 'generates a titles hash from raw data' do
    parser = MKV::Parser.new(raw_data)
    expect(parser.titles).to eq([{track_number: '1', track_id: '0', track_type: 'video', enabled: '1'}])
  end

  def raw_data
    <<-EOF
+ EBML head
|+ Doc type read version: 1
+ Segment, size 7420603
| + Segment UID: 0xa0 0x8d 0xae 0x19 0xd8 0x4f 0xeb 0x17 0xa3 0x26 0x4e 0x03 0x18 0x71 0x8d 0xa6
|+ Segment tracks
| + A track
|  + Track number: 1 (track ID for mkvmerge & mkvextract: 0)
|  + Track type: video
|  + Enabled: 1
EOF
  end
end
describe MKV::Parser, '#chapters' do
  it 'generates a chapter hash from raw data' do
    parser = MKV::Parser.new(raw_data)
    expect(parser.chapters).to eq([{chapter_uid: '1789432733', chapter_language: 'eng', }])
  end

  def raw_data
    <<-EOF
|+ Chapters
| + EditionEntry
|  + EditionUID: 4159917494
|  + ChapterAtom
|   + ChapterUID: 1789432733
|   + ChapterDisplay
|    + ChapterLanguage: eng
EOF
  end
end

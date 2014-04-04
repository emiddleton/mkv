class MKVMock
  def self.info
    <<-EOF
+ EBML head
|+ Doc type: matroska
|+ Doc type version: 1
|+ Doc type read version: 1
+ Segment, size 7420603
|+ Seek head (subentries will be skipped)
|+ EbmlVoid (size: 4013)
|+ Segment information
| + Timecode scale: 1000000
| + Muxing application: libebml v0.7.7 + libmatroska v0.8.1
| + Writing application: mkvmerge v2.6.0 ('Kelly watch the Stars') built on Mar 24 2009 15:23:17
| + Duration: 52.209s (00:00:52.209)
| + Date: Thu May 13 06:09:45 2010 UTC
| + Segment UID: 0xa0 0x8d 0xae 0x19 0xd8 0x4f 0xeb 0x17 0xa3 0x26 0x4e 0x03 0x18 0x71 0x8d 0xa6
|+ Segment tracks
| + A track
|  + Track number: 1 (track ID for mkvmerge & mkvextract: 0)
|  + Track UID: 2395334065
|  + Track type: video
|  + Enabled: 1
|  + Default flag: 1
|  + Forced flag: 0
|  + Lacing flag: 0
|  + MinCache: 1
|  + Timecode scale: 1
|  + Max BlockAddition ID: 0
|  + Codec ID: V_MPEG4/ISO/AVC
|  + Codec decode all: 1
|  + CodecPrivate, length 43 (h.264 profile: High @L4.0)
|  + Default duration: 41.667ms (24.000 frames/fields per second for a video track)
|  + Language: eng
|  + Name: Main title
|  + Video track
|   + Pixel width: 848
|   + Pixel height: 360
|   + Interlaced: 0
|   + Display width: 848
|   + Display height: 360
| + A track
|  + Track number: 2 (track ID for mkvmerge & mkvextract: 1)
|  + Track UID: 3490362511
|  + Track type: audio
|  + Enabled: 1
|  + Default flag: 0
|  + Forced flag: 0
|  + Lacing flag: 1
|  + MinCache: 0
|  + Timecode scale: 1
|  + Max BlockAddition ID: 0
|  + Codec ID: A_AAC
|  + Codec decode all: 1
|  + CodecPrivate, length 5
|  + Default duration: 21.333ms (46.875 frames/fields per second for a video track)
|  + Language: eng
|  + Name: English Stereo
|  + Audio track
|   + Sampling frequency: 48000
|   + Channels: 2
| + A track
|  + Track number: 3 (track ID for mkvmerge & mkvextract: 2)
|  + Track UID: 4068307614
|  + Track type: subtitles
|  + Enabled: 1
|  + Default flag: 0
|  + Forced flag: 0
|  + Lacing flag: 0
|  + MinCache: 0
|  + Timecode scale: 1
|  + Max BlockAddition ID: 0
|  + Codec ID: S_TEXT/UTF8
|  + Codec decode all: 1
|  + Language: eng
|  + Name: English
| + A track
|  + Track number: 4 (track ID for mkvmerge & mkvextract: 3)
|  + Track UID: 3565139130
|  + Track type: subtitles
|  + Enabled: 1
|  + Default flag: 0
|  + Forced flag: 0
|  + Lacing flag: 0
|  + MinCache: 0
|  + Timecode scale: 1
|  + Max BlockAddition ID: 0
|  + Codec ID: S_TEXT/UTF8
|  + Codec decode all: 1
|  + Language: fre
|  + Name: French
|+ EbmlVoid (size: 1024)
|+ Cluster
EOF
  end
end

Rspec.configure do |config|
  config.before(:each) do
    MKV::Movie.stub(:output).and_return(MKVMock.info)
  end
end

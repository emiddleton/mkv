require 'spec_helper'

describe MKV::VideoSplitter do
  describe '#split' do
    it 'splits with chapters' do
      splitter = MKV::VideoSplitter.new('/path/to/video.mkv', [1,2,3])

      allow(Open3).to receive(:popen2).with(command('1,2,3'))

      splitter.split

      expect(Open3).to have_received(:popen2)
    end

    it 'splits all the chapters' do
      splitter = MKV::VideoSplitter.new('/path/to/video.mkv', [])

      allow(Open3).to receive(:popen2).with(command('all'))

      splitter.split

      expect(Open3).to have_received(:popen2)
    end
  end

  def command(input)
    "#{binary} /path/to/video.mkv --split chapters:#{input} -o /path/to/video.episode%d.mkv"
  end

  def binary
    MKV.mkvmerge_binary
  end
end

module MKV
  class Chapters
    include Enumerable

    def initialize(chapters)
      @chapters = chapters
    end

    def each(&block)
      @chapters.each(&block)
    end

    def index(chapter)
      @chapters.index(chapter)
    end

    def offset_index(chapter)
      index(chapter) + 1
    end

    def episodes
      EpisodeFactory.for(@chapters)
    end

    def split!(path, chapter_ids)
      MKV::VideoSplitter.new(path, chapter_ids).split
    end
  end
end

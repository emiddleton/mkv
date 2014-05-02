module MKV
  class Chapters
    include Enumerable

    def initialize(chapters)
      @chapters = chapters
    end

    def each(&block)
      @chapters.each(&block)
    end

    def episodes
      EpisodeFactory.for(@chapters)
    end
  end
end

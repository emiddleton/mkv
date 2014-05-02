module MKV
  class Episode
    include Enumerable

    def initialize(chapters)
      @chapters = chapters
    end

    def each(&block)
      @chapters.each(&block)
    end
  end
end

module MKV
  module EpisodeFactory
    def self.for(chapters)
      ParseChapters.new(chapters).episodes
    end

    private

    class ParseChapters
      def initialize(chapters)
        @chapters = chapters
      end

      def episodes
        episodes = []
        current = []

        normalized_durations.each_with_index do |duration, chapter_index|
          current << @chapters[chapter_index]
          if duration == :short && current.length != 1
            episodes << MKV::Episode.new(current)
            current = []
          end
        end
        episodes
      end

      def normalized_durations
        durations.map do |short|
          if shorts.include?(short)
            :short
          else
            :long
          end
        end
      end

      def shorts
        sorted_durations[0..deltas.index(max)]
      end

      def deltas
        sorted_durations.each_cons(2).map { |x,y| y - x }
      end

      def sorted_durations
        durations.sort
      end

      def max
        deltas.max
      end

      def durations
        @chapters.map { |chapter| chapter.duration }
      end
    end
  end
end

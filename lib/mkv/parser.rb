module MKV
  class Parser
    def initialize(data)
      @data = data
    end

    def titles
      @data.split("| + A track")[1..-1].each.map do |track|
        a3 = track.scan(/\|\s+\+\s+([^\:|^\n]+):\s([^\n[(])]+)/)
        a2 = track.scan(/\s+\+\s+Track number: \d+ \((track ID) for mkvmerge & mkvextract: (\d+)\)/)
        a3.concat(a2)
        to_hash(a3)
      end
    end

    def chapters
      @data.split("|  + ChapterAtom")[1..-1].each.map do |chapter|
        a3 = chapter.scan(/\|\s+\+\s+([^\:|^\n]+):\s([^\n[\s(])]+)/)
        to_hash(a3)
      end
    end

    def duration
      @data.scan(/\|[^\w]+Duration:\s(\d+)/).flatten.first
    end

    private

    def to_hash(array)
      Hash[
        array.map do |key, value|
          [convert_to_snake(key), value.strip]
        end
      ]
    end

    def convert_to_snake(string)
      if string.match(' ')
        string.gsub(' ', '_').downcase.to_sym
      else
        string.scan(/([A-Z][^A-Z]+|[A-Z]+)/).join('_').downcase.to_sym
      end
    end
  end
end

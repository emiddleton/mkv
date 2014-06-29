module MKV
  class Chapter
    attr_accessor :duration

    def initialize(attributes)
      @time_start = attributes.fetch(:chapter_time_start)
      @language = attributes.fetch(:chapter_language).to_sym
      @uid = attributes.fetch(:chapter_uid).to_i
    end

    def start_time
      @start_time ||= ISO8601::Duration.new(parse_time).to_seconds
    end

    private

    def parse_time
      split_time = @time_start.split(':')
      "PT#{split_time[0]}H#{split_time[1]}M#{split_time[2]}S"
    end
  end
end

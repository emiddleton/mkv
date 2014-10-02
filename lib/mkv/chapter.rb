module MKV
  class Chapter
    def initialize(attributes)
      @time_start = attributes.fetch(:chapter_time_start)
      @time_end = attributes.fetch(:chapter_time_end)
      @language = attributes.fetch(:chapter_language).to_sym
      @uid = attributes.fetch(:chapter_uid).to_i
    end

    def start_time
      @start_time ||= ISO8601::Duration.new(parsed_start_time).to_seconds
    end

    def duration
      (end_time - start_time).round(4)
    end

    private

    def end_time
      @end_time ||= ISO8601::Duration.new(parsed_end_time).to_seconds
    end

    def parsed_start_time
      parse_time(@time_start)
    end

    def parsed_end_time
      parse_time(@time_end)
    end

    def parse_time(time)
      time_splits = time.split(':')
      "PT#{time_splits[0]}H#{time_splits[1]}M#{time_splits[2]}S"
    end
  end
end

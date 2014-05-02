module MKV
  class Chapter
    attr_accessor :duration

    def initialize(attributes)
      @time_start = attributes.fetch(:chapter_time_start)
      @language = attributes.fetch(:chapter_language).to_sym
      @uid = attributes.fetch(:chapter_uid).to_i
    end

    def start_time
      @start_time ||= Timestamp.new(@time_start).to_seconds
    end
  end
end

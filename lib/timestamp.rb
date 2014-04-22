class Timestamp
  HOUR = 3600
  MINUTE = 60

  def initialize(timestamp)
    @timestamp = timestamp
  end

  def to_seconds
    hours * HOUR + minutes * MINUTE + seconds
  end

  def to_milliseconds
    "#{to_seconds}#{milliseconds}"
  end

  def seconds
    @seconds ||= split_times[0].to_i
  end

  def minutes
    @minutes ||= split_times[1].to_i
  end

  def hours
    @hours ||= split_times[2].to_i
  end

  def milliseconds
    @milliseconds ||= decimal[0..2].to_i
  end

  private

  def base
    @timestamp.split('.')[0]
  end

  def decimal
    @timestamp.split('.')[1]
  end

  def split_times
    base.split(':').reverse
  end
end

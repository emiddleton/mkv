module MKV
  class VideoTrack < Track

    attr_reader :width, :height

    def initialize(data)
      super(data)
      @width = data.fetch(:pixel_width).to_i
      @height = data.fetch(:pixel_height).to_i
    end
  end

end

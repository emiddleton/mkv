module MKV
  class Track
    # Video, Audio & Subtitle
    attr_reader :type, :uid, :number, :mkv_info_id, :lacing, :codec_id

    def initialize(data)
      @number = data.fetch(:track_number).to_i
      @mkv_info_id = @number - 1
      @uid = data.fetch(:track_uid)
      @type = data.fetch(:track_type)
      @codec_id = data.fetch(:codec_id)
    end
  end
end

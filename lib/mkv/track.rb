module MKV
  class Track
    # Video, Audio & Subtitle
    attr_reader :type, :uid, :number, :mkv_info_id, :lacing, :codec_id
    # Subtitle & Audio
    attr_reader :language, :enabled, :default, :forced

    def initialize(data)
      @number = data.fetch(:track_number).to_i
      @mkv_info_id = @number - 1
      @uid = data.fetch(:track_uid)
      @lacing = data.fetch(:lacing_flag) != '0'
      @type = data.fetch(:track_type)
      @codec_id = data.fetch(:codec_id)

      @language = data[:language]

    end
  end
end

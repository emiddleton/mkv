module MKV
  class SubtitlesTrack < Track
    attr_reader :language, :enabled, :default, :forced

    def initialize(data)
      super(data)
      @language = data.fetch(:language)
      @enabled = data.fetch(:enabled)
      @default = data.fetch(:default_flag) != '0'
      @forced = data.fetch(:forced_flag) != '0'
    end
  end
end

module MKV
  class AudioTrack < Track
    attr_reader :sampling_frequency, :channels, :language, :enabled, :default_flag, :forced_flag

    def initialize(data)
      super(data)
      @sampling_frequency = data.fetch(:sampling_frequency).to_i
      @channels = data.fetch(:channels).to_i
      @language = data.fetch(:language)
    end
  end
end

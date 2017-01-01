module MKV
  class AudioTrack < Track
    attr_reader :sampling_frequency, :channels, :language, :name, :enabled, :default_flag, :forced_flag

    def initialize(data)
      super(data)
      @sampling_frequency = data.fetch(:sampling_frequency).to_i
      @channels = data[:channels].to_i
      @language = data[:language]
      @name = data[:name]
    end
  end
end

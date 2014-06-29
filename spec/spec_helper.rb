require 'rspec'
require 'mkv'
require 'timestamp'
require 'tmpdir'
require 'fileutils'

Dir[Dir.pwd + '/spec/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.include Features

  config.order = 'random'

  config.before(:all) do
    MKV.logger = Logger.new(StringIO.new)
  end

  config.after(:all) do
    MKV.logger = nil
  end
end

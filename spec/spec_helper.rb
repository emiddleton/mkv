require 'rspec'
require 'mkv'
require 'tmpdir'
require 'fileutils'

Dir[Dir.pwd + '/spec/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.include Features

  config.order = 'random'

  config.before(:all) do
    MKV.logger = Logger.new(StringIO.new)
  end

  config.after(:all) do
    MKV.logger = nil
  end
end

module Features
  def temporary_fixture(filename)
    Dir.mktmpdir do |dir|
      FileUtils.cp("spec/fixtures/#{filename}", dir)
      yield(dir)
    end
  end
end

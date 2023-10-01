require 'json'

class DataSaver
  def initialize(data, filename)
    @data = data
    @filename = filename
  end

  def save
    File.open(@filename, 'w') do |file|
      file.write(JSON.pretty_generate(@data))
    end
  end
end
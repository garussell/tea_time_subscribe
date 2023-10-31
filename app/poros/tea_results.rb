class TeaResults
  attr_reader :id, :data, :title, :description, :image, :link

  def initialize(data)
    @id = data[:id]
    @title = data[:name]
    @description = data[:content]
    @image = data[:image]
    @link = data[:link]
  end
end
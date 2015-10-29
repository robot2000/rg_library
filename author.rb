class Author
  attr_reader :name
  attr_accessor :bio

  def initialize(name, bio)
  	@name = name
  	@bio= bio
  end

  def to_s
    "#{@name}\nbio: #{@bio}"[0..60]
  end
end

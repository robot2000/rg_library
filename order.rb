class Order
  attr_accessor :book
  attr_accessor :reader
  attr_accessor :date

  def initialize (book, reader, date = Time.now)
    @book = book
    @reader = reader
    @date = date
  end

  def to_s
    "The #{@book} was taken by #{@reader}"
  end
end

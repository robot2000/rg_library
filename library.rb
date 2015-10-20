require "./book"
require "./order"
require "./reader"
require "./author"

class Library
  attr_reader :books
  attr_reader :orders
  attr_reader :readers
  attr_reader :authors

  def initialize
    @books   = []
    @authors = []
    @readers = []
    @orders  = []
  end

  def add_book (book)
    @books.push book unless @books.include? book
    @authors.push book.author unless @authors.include? book.author

    self
  end

  def add_reader(reader)
    @readers << reader
  end

  def add_order(order)
    @orders << order
  end

  def add_author(author)
    @authors << author
  end

 #--------------------------------------------------------------

 # Who often takes the book
  def top_readers
    hash = @orders.inject(Hash.new(0)) do |count, order|
      count[order.reader.name] += 1
      count
    end
    top = hash.max_by { |key, value| value }.first
    puts "Active reader is: #{top}"
  end

 # What is the most popular book
  def top_books
    if orders.empty?
      puts "There are not orders..."
    else
      @orders.group_by(&:book).values.max_by(&:size).first.book
    end
  end

 # How many people ordered one of the three most popular books
  def how_orders_of_three_most_popular_books
    books_count.each {|title, times| puts "The most popular books, '#{title}', ordered #{times}" if times == books_count.values.max }
  end

  private

  def books_count
    titles = @orders.map {|el| el.book.title }
    count = Hash.new(0)
    titles.each {|el| counts[el] += 1 }
    count
  end
end

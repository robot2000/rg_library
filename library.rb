require "yaml"
require "./book"
require "./order"
require "./reader"
require "./author"

class Library
  attr_accessor :books, :orders, :readers, :authors

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

  def save_to_file(file)
    File.open('library.yaml', 'w') { |f| f.write self.to_yaml }
  end

  def load_from_file(file)
    load = YAML.load_file('library.yaml')
    @books   = load.books
    @authors = load.authors
    @readers = load.readers
    @orders  = load.orders
  end

  private

  def books_count
    titles = @orders.map {|el| el.book.title }
    count = Hash.new(0)
    titles.each {|el| count[el] += 1 }
    count
  end
end

reader1 = Reader.new('John', 'john@mail.com', 'Sydney', 'Short str', '223')
reader2 = Reader.new('Jac', 'jac@mail.com', 'Paris', "Notre Dam ave", '26')
reader3 = Reader.new('Pedro', 'pedro@mail.com', 'Barselona', 'Ocean ave', '789')
reader4 = Reader.new('Ivanko', 'ivanko@mail.com', 'Lviv', 'Banderi str', '1-a')
reader5 = Reader.new('Ivaris', 'ivaris@mail.com', 'Oslo', 'North str', '1236')

suvorov = Author.new('Viktor Suvorov', 'born to 1947 in USSR')
marks = Author.new('Karl Marks', 'born to 1818 in Germany')
shevchenko = Author.new('Taras Shevchenko', 'born to 1814 in Ukraine')
matsumoto = Author.new('Yokihiro Matsumoto', 'born to 1965 in Japan')

book1 = Book.new('Icebracker', suvorov)
book2 = Book.new('Das Kapital', marks)
book3 = Book.new('The Kobzar', shevchenko)
book4 = Book.new('The Ruby language', matsumoto)
book5 = Book.new("M-day", suvorov)

order1 = Order.new(book1, reader1)
order2 = Order.new(book2, reader2)
order3 = Order.new(book1, reader3)
order4 = Order.new(book4, reader3)
order5 = Order.new(book4, reader2)
order6 = Order.new(book4, reader5)
order7 = Order.new(book2, reader2)
order8 = Order.new(book5, reader4)
order9 = Order.new(book3, reader1)
order10 = Order.new(book5, reader2)

library = Library.new

library.add_book(book1)
library.add_book(book2)
library.add_book(book3)
library.add_book(book4)
library.add_book(book5)

library.add_author(suvorov)
library.add_author(marks)
library.add_author(shevchenko)
library.add_author(matsumoto)

library.add_reader(reader1)
library.add_reader(reader2)
library.add_reader(reader3)
library.add_reader(reader4)
library.add_reader(reader5)



library.add_order(order1)
library.add_order(order2)
library.add_order(order3)
library.add_order(order4)
library.add_order(order5)
library.add_order(order6)
library.add_order(order7)
library.add_order(order8)
library.add_order(order9)
library.add_order(order10)

library.top_readers
library.top_books
library.how_orders_of_three_most_popular_books

library.save_to_file('library.yaml')

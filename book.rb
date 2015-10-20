class Book
  attr_accessor :title
  attr_accessor :author

  def initialize (title, author)
    @title = title
    @author = author
  end

  def to_s
    "The #{@title}, written by #{@author}"
  end
end

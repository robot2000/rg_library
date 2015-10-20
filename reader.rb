class Reader
  attr_accessor :name
  attr_accessor :email
  attr_accessor :city
  attr_accessor :street
  attr_accessor :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end
    
  def to_s
    "name: #{@name}\nemail: #{@email}\ncity: #{@city}"
  end
end

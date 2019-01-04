class Drink
  attr_reader :name, :price
  #alias_method :eql, :==

  def initialize(name, price)
    @name = name
    @price = price
  end

  def info
    puts "ドリンク名：#{name}、値段：#{price}"
  end

  # def ==(other)
  #   return self.name == other.name && self.price == other.price
  #   eql(other)
  # end
end

drink = Drink.new("coke", 140)
drink.info

class Drink
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def info
    puts "ドリンク名：#{name}、値段：#{price}"
  end
end

drink = Drink.new("coke", 140)
drink.info

class Drink
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def info
    puts "ドリンク名：#{name}\n値段：#{price}"
  end
end

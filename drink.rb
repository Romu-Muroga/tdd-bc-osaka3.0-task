class Drink
  attr_reader :name, :price
  #attr_accessor :stock
  #alias_method :eql, :==

  def initialize(name, price)
    @name = name
    @price = price
  end

  # 初期設定（コーラのみ）
  # def initialize(name, price, stock)
  #   @name = name
  #   @price = price
  #   @stock = stock #TODO: 消す
  # end

  def info
    puts "ドリンク名：#{name}\n値段：#{price}"
  end
  # 情報（コーラのみ）
  # def info
  #   puts "ドリンク名：#{name}\n値段：#{price}\n在庫：#{stock}"
  # end

  # def ==(other)
  #   return self.name == other.name && self.price == other.price
  #   eql(other)
  # end
end

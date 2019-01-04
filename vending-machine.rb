require "./drink"
# require "./vending-machine.rb"

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000]

  attr_reader :total, :stock

  def initialize
    @total = 0
    @stocks = []
    5.times { @stocks << Drink.new("コーラ", 120) }
    10.times { @stocks << Drink.new("ファンタ", 140) }
  end

  def show_admin
    @stocks.each do |stock|
      puts "値段#{stock.price} \n 名前#{stock.name} \n 在庫#{poly_stock_count(stock.name)}"
    end
  end

  def poly_stock_count(name)
    @stocks.select { |stock| stock.name == name }.count
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  def insert_money(money)
    # 利用可能なお金か判定
    if AVAILABLE_MONEY.include?(money)
      # 投入金額の総計を取得できる。
      @total += money
      puts "投入金額の合計は#{total}円です。"
    else
      # 想定外のもの（硬貨：１円玉、５円玉。お札：千円札以外のお札）が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
      puts "#{money}円は使用できません。"
    end
  end
  # 払い戻し操作
  def pay_back
    puts "#{total}円のお返しです。"
    @total = 0
  end
  # 在庫
  # def stock
  #   @stock.
  # end
end

# for example
# vending_machine = VendingMachine.new
# vending_machine.insert_money(100)
# vending_machine.insert_money(500)
# vending_machine.pay_back
# vending_machine.total

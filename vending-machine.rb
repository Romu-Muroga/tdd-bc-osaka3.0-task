require "./drink"
require "./category"
# require "./vending-machine.rb"

class VendingMachine
  # 利用可能なお金
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000]
  attr_reader :total, :sale_amount#, :coke

  # 初期設定
  def initialize
    @total = 0
    @sale_amount = 0
    @stocks = []
  end

  # 初期設定（コーラのみ）
  # def initialize
  #   @total = 0
  #   @sale_amount = 0
  #   @coke = Drink.new("コーラ", 120, 5) # TODO:
  # end

  def example
    drinks = []
    drinks.push(Drink.new("コーラ", 120))
    drinks.push(Drink.new("コーラ", 120))
    drinks.push(Drink.new("コーラ", 120))
    drinks.push(Drink.new("コーラ", 120))
    drinks.push(Drink.new("コーラ", 120))
    c = Category.new(drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
  end

  def example_purchase
    example_drink_menu
    input = gets.to_i
    if input > 0
      input -= 1 #@stocks[input].drinks.first == @coke
      if @stocks[input].drinks.length > 0
        if @stocks[input].drinks.first.price <= @total
          @total -= @stocks[input].drinks.first.price
          @sale_amount += @stocks[input].drinks.first.price
          puts "#{@stocks[input].drinks.first.name}を購入しました。"
          # 削除後、再代入しないとエラーになる
          @stocks[input].drinks = @stocks[input].drinks.drop(1)
        else
          puts "#{@stocks[input].drinks.first.price - total}円不足しています。お金を投入して下さい。"
        end
      else
        puts "売り切れです。申し訳ありません！"
      end
    elsif input == 0
      pay_back
    end
  end

  def example_drink_menu
    puts "投入金額は#{total}円です。"
    puts "以下の品目から商品を選んでください"
    puts "------------------------------------"
    unless @stocks.empty?
      @stocks.each_with_index do |stock, idx|
        puts "[#{idx + 1}]:#{stock.drinks.first.name}　#{stock.drinks.first.price}円" unless stock.drinks.empty?
      end
    end
    puts "------------------------------------"
    puts "[0]払い戻し"
  end
# Drink.new("コーラ", 120, 5) みたいなのを持つのをcategory class
# category class = Drink.new("コーラ", 120, 5) no1
# category class = Drink.new("ファンタ", 120, 5) no2
# VendingMachine.stocks = [ no1, no2 ] = [ [Drink(コーラ), Drink(コーラ), Drink(コーラ), Drink(コーラ)], [Drink(ファンタ), Drink(ファンタ), Drink(ファンタ), Drink(ファンタ)] ]
# VendingMachine.items = ["コーラ", "ファンタ" ]

  # 在庫状況（コーラのみ）
  # def stock_info
  #   @coke.info
  # end

  # ドリンクを格納する（コーラのみ）
  # def store(num)
  #   @coke.stock += num
  # end

  # 購入（コーラのみ）
  # def purchase
  #   drink_menu
  #   input = gets.to_i
  #   if input == 1
  #     if @coke.stock > 0
  #       if @coke.price <= @total
  #         @total -= @coke.price
  #         @sale_amount += @coke.price
  #         @coke.stock -= 1
  #         puts "#{coke.name}を購入しました。"
  #       else
  #         puts "#{coke.price - total}円不足しています。お金を投入して下さい。"
  #       end
  #     else
  #       puts "売り切れです。申し訳ありません！"
  #     end
  #   elsif input == 0
  #     pay_back
  #   end
  # end

  # ドリンクメニュー（コーラのみ）
  # def drink_menu
  #   puts "投入金額は#{total}円です。"
  #   puts "以下の品目から商品を選んでください"
  #   puts "------------------------------------"
  #   puts "[1]#{coke.name}　#{coke.price}円"
  #   puts "------------------------------------"
  #   puts "[0]払い戻し"
  # end

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
end

# for example
# 自販機をスタート
# vending_machine = VendingMachine.new

# お金を投入するするとき
# vending_machine.insert_money(100)
# vending_machine.insert_money(500)

# 払い戻し操作
# vending_machine.pay_back

# 投入金額合計
# vending_machine.total

# 在庫確認
# vending_machine.stock_info

# 購入操作
# vending_machine.purchase

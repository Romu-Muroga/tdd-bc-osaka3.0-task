require "./drink"
require "./category"
# require "./vending-machine.rb"

class VendingMachine
  # 利用可能なお金
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000]
  attr_reader :total, :sale_amount, :stocks, :unsdn

  # 初期設定（変更後）
  def initialize
    @total = 0
    @sale_amount = 0
    @stocks = []
    @drinks = []
    5.times { @drinks.push(Drink.cola) }
    c = Category.new(@drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
    @unsdn = []
  end

  # 初期設定（変更前）
  # def initialize
  #   @total = 0
  #   @sale_amount = 0
  #   @stocks = []
  #   @stocks << Category.new
  # end

  # 購入操作
  def purchase
    drink_menu
    input = gets
    if input == "x\n"
      pay_back
    elsif input != "x\n"
      @int = input.to_i
      unless @stocks[@int].drinks.empty?
        purchase_select(@int)
      end
    end
  end

  # 払い戻し操作
  def pay_back
    puts "#{total}円のお返しです。"
    @total = 0
  end

  # ドリンク選択
  def purchase_select(int)#@intにすると引数ではなくインスタンス変数を参照しに行ってしまいエラーになる。
    # p int
    if @stocks[int].drinks.length > 0
      # p "出力されれば処理が飛んできている(1)"
      if @stocks[int].drinks.first.price <= @total
        @total -= @stocks[int].drinks.first.price
        @sale_amount += @stocks[int].drinks.first.price
        puts "#{@stocks[int].drinks.first.name}を購入しました。"
        # 削除後、再代入しないと初回購入時は削除されるけど次回購入時以降は削除されなくなる。
        @stocks[int].drinks = @stocks[int].drinks.drop(1)
      else
        puts "#{@stocks[int].drinks.first.price - @total}円不足しています。お金を投入して下さい。"
      end
    end
  end

  # ドリンクメニュー
  def drink_menu
    puts "投入金額 #{total}円"
    puts "-----------------------------------------"
    unless @stocks.empty?
      @stocks.each_with_index do |stock, idx|
        unless stock.drinks.empty?
          @unsdn << stock.drinks.first.name unless @unsdn.include?(stock.drinks.first.name)#品切れ中のドリンク名を保管するための配列を準備
          # p @unsdn
        end
        puts "[#{idx}]:#{stock.drinks.first.name}　#{stock.drinks.first.price}円" unless stock.drinks.empty?
        puts "[#{idx}]:#{@unsdn[idx]}は、ただいま品切れ中です。" if stock.drinks.empty?
      end
    end
    puts "-----------------------------------------"
    puts "[x]払い戻し"
    puts ""
    puts "商品番号を選択してください。"
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  def insert_money(money)
    # 利用可能なお金か判定
    if AVAILABLE_MONEY.include?(money)
      # 投入金額の総計を取得できる。
      @total += money
      puts "投入金額の合計は#{@total}円です。"
    else
      # 想定外のもの（硬貨：１円玉、５円玉。お札：千円札以外のお札）が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
      puts "#{money}円は使用できません。"
    end
  end

  # ドリンク補充操作
  def store(drink, num)
    stocks_delete
    @unsdn = []
    @drinks = []
    num.times { @drinks.push(drink) }
    c = Category.new(@drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
  end

  # 空の配列を削除
  def stocks_delete
    # p "出力されれば処理が飛んできている(2)"
    # p @stocks
    @stocks.delete_if do |n|
      n.drinks.empty?
    end
    # p @stocks

    # if @stocks[int].drinks.length == 0
    #   p "出力されれば処理が飛んできている(2)"
    #   p @stocks
    #   # @stocks = @stocks.delete_at(input)
    #   # @stocks = @stocks[input].delete_if(&:empty?)
    #   # @stosks = @stocks.flatten(1).compact
    #   # @stocks.select { |item| !item.is_a?(Array) || !item.empty? }
    #   # @stocks[input] = @stocks[input].drop(1)
    #   @stocks.delete_if do |n|
    #     n.drinks.empty?
    #   end
    #   p @stocks
    #   # int -= 1
    # end
  end

  # 在庫確認（変更後）
  def stock_info
    @new_stocks = []
    @stocks.each do |stock|
      # p @stocks
      # p "--------"
      # p stock.drinks
      # p "--------"
      # 在庫を保有している配列を@new_stocksに格納
      unless stock.drinks.empty?
        @new_stocks << stock
      end
      # p @new_stocks
      # p "--------"
    end
    unless @new_stocks.empty?
      @new_stocks.each_with_index do |stock, idx|
        puts "名前:#{stock.drinks.first.name} \n 値段:#{stock.drinks.first.price} \n 在庫:#{stock_count(stock.drinks.first.name, idx)}"
      end
    else
      puts "在庫切れです。"
    end
  end

  # ドリンク毎の在庫を計算（変更後）
  def stock_count(name, idx)
    @new_stocks[idx].drinks.select { |drink| drink.name == name }.count
  end

  # 在庫確認（変更前）
  # def stock_info
  #   @stocks.each_with_index do |stock, idx|
  #     puts "名前#{stock.cokes.last.name} \n 値段#{stock.cokes.last.price} \n 在庫#{stock_count(stock.cokes.last.name, idx)}"
  #   end
  # end

  # ドリンク毎の在庫を計算（変更前）
  # def stock_count(name, idx)
  #   # @stocks[idx].cokes.select { |coke| coke.name == name }.count
  #   @stocks[idx].cokes.length - 1
  # end

end

# for example
# 自販機をスタート
# machine = VendingMachine.new

# お金を投入するするとき
# machine.insert_money(100)
# machine.insert_money(500)

# 購入操作
# machine.purchase

# 投入金額合計
# machine.total

# 売り上げ金額の表示
# machine.sale_amount

# 在庫確認
# machine.stock_info

# ドリンク補充
# 新規でドリンクを補充するとき
# machine.store(Drink.new("ドリンク名", 値段), 個数)
# 既存のドリンクを補充するとき
# machine.store(Drink.cola, 5)
# machine.store(Drink.redbull, 5)
# machine.store(Drink.water, 5)

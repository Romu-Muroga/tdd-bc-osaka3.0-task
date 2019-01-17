require "./drink"

class Category
  attr_accessor :drinks

  def initialize(drinks)
    @drinks = drinks
  end

  # 同じドリンクしか入っていなければtrue 一つでも違うのがあるとfalse
  def validate_unique
    @drinks.each do |drink1|
      @drinks.each do |drink2|
        return false unless drink1.name === drink2.name || drink1.price === drink2.price
        break
      end
    end
    true
  end

  # ドリンククラス以外が入っていなければtrue 一つでも違うのがあるとfalse
  def validate_class
    @drinks.each { |drink| return false unless drink.kind_of?(Drink) }
    true
  end
end

# arr = ["1", "2", "3", "4"]
# arr.each do |a|
#   arr.each do |b|
#     puts a
#     puts b
#   end
# end

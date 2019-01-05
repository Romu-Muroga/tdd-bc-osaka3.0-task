require "./drink"

class Category
  attr_accessor :drinks

  def initialize(drinks)
    @drinks = drinks
  end

  #同じドリンクしか入っていなければtrue 一つでも違うのがあるとfalse
  def validate_unique
    @drinks.each do |drink1|
      @drinks.each do |drink2|
        return false unless drink1.name === drink2.name || drink1.price === drink2.price
        break
      end
    end
    return true
  end

  #ドリンククラス以外が入っていなければtrue 一つでも違うのがあるとfalse
  def validate_class
    @drinks.each do |drink|
      return false unless drink.kind_of?(Drink)
    end
    return true
  end
end

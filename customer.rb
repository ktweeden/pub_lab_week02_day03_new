class Customer

attr_reader :wallet, :age
attr_accessor :drunkenness

  def initialize(name, wallet, age)
    @name = name
    @wallet = wallet
    @age = age
    @drunkenness = 0
  end

  def reduce_wallet(amount)
    return false if amount > wallet
    @wallet -= amount
  end

  def increase_drunkenness(drink)
    @drunkenness += drink.alcohol_level
  end

  def decrease_drunkenness(food)
    @drunkenness -= food.rejuvenation_level if @drunkenness > 0
  end


  def buy_drink(drink)
    increase_drunkenness(drink)
    reduce_wallet(drink.price)
  end

  def buy_food(food)
    decrease_drunkenness(food)
    reduce_wallet(food.price)
  end

end

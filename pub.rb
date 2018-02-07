require_relative("drink")
require_relative("food")

class Pub

  def initialize(name)
    @name = name
    @till = 100
    @drinks = [
      Drink.new("Vodka", 4, 7),
      Drink.new("Whiskey", 11, 4),
      Drink.new("Gin", 4, 6),
      Drink.new("Scotch", 5, 7)
    ]
    @foods = [
      Food.new("Porridge", 2, 7),
      Food.new("Pie", 5, 6),
      Food.new("Chips", 3, 3),
    ]
  end

  def increase_till(amount)
    @till += amount
  end

  def find_drink_by_name(name)
    for drink in @drinks
      return drink if drink.name == name
    end
    return nil
  end

  def find_food_by_name(name)
    for food in @foods
      return food if food.name == name
    end
    return nil
  end

  def check_drunkenness(customer)
    return customer.drunkenness() <= 20
  end

  def sell_drink(customer, drink_name)
    return false if !check_age(customer)
    return false if !check_drunkenness(customer)
    drink = find_drink_by_name(drink_name)
    return false if drink == nil
    return false if !customer.reduce_wallet(drink.price)
    increase_till(drink.price)
    return true
  end

  def sell_food(customer, food_name)
    food = find_food_by_name(food_name)
    return false if food == nil
    return false if !customer.reduce_wallet(food.price)
    increase_till(food.price)
    return true
  end

  def check_age(customer)
    return customer.age >= 18
  end

end

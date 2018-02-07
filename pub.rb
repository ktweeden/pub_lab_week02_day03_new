require_relative("drink")
require_relative("food")

class Pub

  attr_reader :stock
  def initialize(name)
    @name = name
    @till = 100
    # @drinks = [
    #   Drink.new("Vodka", 4, 7),
    #   Drink.new("Whiskey", 11, 4),
    #   Drink.new("Gin", 4, 6),
    #   Drink.new("Scotch", 5, 7)
    # ]
    # @foods = [
    #   Food.new("Porridge", 2, 7),
    #   Food.new("Pie", 5, 6),
    #   Food.new("Chips", 3, 3),
    # ]

    @stock = {
      drinks: [
        {
          name: "Vodka",
          price: 4,
          alcohol_level: 7 ,
          quantity: 10
        },
        {
          name: "Whiskey",
          price: 11,
          alcohol_level: 4,
          quantity: 10
        },
        {
          name: "Gin",
          price: 4,
          alcohol_level: 6,
          quantity: 10
        },
        {
          name: "Scotch",
          price: 4,
          alcohol_level: 7,
          quantity: 10
        },
      ],
      foods: [
        {
          name: "Porridge",
          price: 2,
          rejuvenation_level: 7,
          quantity: 10
        },
        {
          name: "Pie",
          price: 5,
          rejuvenation_level: 6,
          quantity: 10
        },
        {
          name: "Chips",
          price: 3,
          rejuvenation_level: 3,
          quantity: 10
        }
      ],
      drinks_stock_count: 40,
      foods_stock_count: 30,
      total_stock_count: 70
    }
  end

  def stock_decrease_drink(name)
    for drink in @stock[:drinks]
      if drink[:name] == name
        drink[:quantity] -= 1
        @stock[:drinks_stock_count] -= 1
        @stock[:total_stock_count] -= 1
      end
    end
  end

  def stock_decrease_food(name)
    for food in @stock[:foods]
      if food[:name] == name
        food[:quantity] -= 1
        @stock[:foods_stock_count] -= 1
        @stock[:total_stock_count] -= 1
      end
    end
  end

  def increase_till(amount)
    @till += amount
  end

  def find_drink_by_name(name)
    for drink in @stock[:drinks]
      return drink if drink[:name] == name
    end
    return nil
  end

  def find_food_by_name(name)
    for food in @stock[:foods]
      return food if food[:name] == name
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
    return false if !customer.reduce_wallet(drink[:price])
    increase_till(drink[:price])
    stock_decrease_drink(drink_name)
    return true
  end

  def sell_food(customer, food_name)
    food = find_food_by_name(food_name)
    return false if food == nil
    return false if !customer.reduce_wallet(food[:price])
    increase_till(food[:price])
    stock_decrease_food(food_name)
    return true
  end

  def check_age(customer)
    return customer.age >= 18
  end

end

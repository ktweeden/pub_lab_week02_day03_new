require('minitest/autorun')
require_relative('../pub')
require_relative('../customer')

class TestPub < MiniTest::Test

  def setup
    @pub = Pub.new("The Chanter")
    @customer = Customer.new("Kate", 10, 28)
    @young_customer = Customer.new("Miguel", 8, 17)
    @drink = Drink.new("Gin", 4, 6)
    @drunk_customer = Customer.new("Darren", 100, 29)
    @food = Food.new("Porridge", 2, 7)
  end

  def test_increase_till()
    result = @pub.increase_till(4)
    assert_equal(104, result)
  end

  def sell_food()
    result = @pub.sell_food(@customer, "Porridge")
    assert_equal(true, result)
    assert_equal(29, @pub.stock[:foods_stock_count])
  end

  def test_sell_drink()
    result = @pub.sell_drink(@customer, "Gin")
    assert_equal(true, result)
    assert_equal(39, @pub.stock[:drinks_stock_count])
  end

  def test_sell_drink__not_enough_money()
    result = @pub.sell_drink(@customer, "Whiskey")
    assert_equal(false, result)
    assert_equal(10, @customer.wallet)
  end

  def test_sell_drink__does_not_exist()
    result = @pub.sell_drink(@customer, "Rum")
    assert_equal(false, result)
  end

  def test_sell_drink__too_young()
    result = @pub.sell_drink(@young_customer, "Whiskey")
    assert_equal(false, result)
  end

  def test_sell_drink__too_drunk()
    @drunk_customer.buy_drink(@drink)
    @drunk_customer.buy_drink(@drink)
    @drunk_customer.buy_drink(@drink)
    @drunk_customer.buy_drink(@drink)
    result = @pub.sell_drink(@drunk_customer, @drink)
    assert_equal(false, result)
  end

  def test_check_drunkenness()
    result = @pub.check_drunkenness(@customer)
    assert_equal(true, result)
  end

  def test_check_age()
    result = @pub.check_age(@customer)
    assert_equal(true, result)
  end

  def test_check_age__young()
    result = @pub.check_age(@young_customer)
    assert_equal(false, result)
  end

  def test_find_drink_by_name()
    result = @pub.find_drink_by_name("Gin")
    assert_equal("Gin", result[:name])
  end

  def test_find_drink_by_name__does_not_exist()
    result = @pub.find_drink_by_name("Rum")
    assert_equal(nil, result)
  end

  def test_find_food_by_name()
    result = @pub.find_food_by_name("Porridge")
    assert_equal(@food.name, result[:name])
  end

  def test_find_food_by_name__does_not_exist()
    result = @pub.find_food_by_name("Chicken")
    assert_equal(nil, result)
  end

  def test_stock_decrease_drink()
    @pub.stock_decrease_drink("Vodka")
    assert_equal(69, @pub.stock[:total_stock_count])
    assert_equal(39, @pub.stock[:drinks_stock_count])
    assert_equal(9, @pub.stock[:drinks][0][:quantity])
  end
  def test_stock_decrease_food()
    @pub.stock_decrease_food("Porridge")
    assert_equal(69, @pub.stock[:total_stock_count])
    assert_equal(29, @pub.stock[:foods_stock_count])
    assert_equal(9, @pub.stock[:foods][0][:quantity])
  end
end

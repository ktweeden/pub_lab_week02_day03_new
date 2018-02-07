require('minitest/autorun')
require_relative("../customer")
require_relative("../drink")
require_relative("../food")

class TestCustomer < MiniTest::Test
  def setup
    @customer = Customer.new("Kate", 10, 28)
    @customer2 = Customer.new("Miguel", 8, 24)
    @drink = Drink.new("Gin", 4, 6)
    @food = Food.new("Porridge", 2, 7)
  end

  def test_reduce_wallet()
    result = @customer.reduce_wallet(4)
    assert_equal(6, result)
  end

  def test_reduce_wallet__not_enough_money()
    result = @customer.reduce_wallet(11)
    assert_equal(false, result)
  end

  def test_increase_drunkenness()
    @customer.increase_drunkenness(@drink)
    assert_equal(6, @customer.drunkenness)
  end

  def test_decrease_drunkenness()
    @customer.buy_drink(@drink)
    @customer.buy_drink(@drink)
    @customer.buy_drink(@drink)
    @customer.decrease_drunkenness(@food)
    @customer2.decrease_drunkenness(@food)
    assert_equal(11, @customer.drunkenness)
    assert_equal(0, @customer2.drunkenness)
  end

  def test_buy_drink()
    result = @customer.buy_drink(@drink)
    assert_equal(6, result)
  end

  def test_buy_food()
    result = @customer.buy_food(@food)
    assert_equal(8, result)
  end


end

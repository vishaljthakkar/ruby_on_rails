class CalculatorTest < Test::Unit::TestCase
  def setup
    @calc = Calculator.new("test")
  end
  def test_addition
    assert_equal 4, @calc.add(2, 2)
  end
  def test_subtraction
    assert_equal 2, @calc.subtract(4, 2)
  end
  def test_multiplication
    assert_equal 10, @calc.multiply(5, 2)
  end
  def test_division
    assert_equal 2, @calc.divide(10, 5)
  end
  def test_divide_by_zero
    assert_raise ZeroDivisionError do
      @calc.divide(1, 0)
    end
  end
end

require 'test/unit'
require_relative 'string_calculator'

class TestStringCalculator < Test::Unit::TestCase
  def setup
    @calculator = StringCalculator.new
  end
  
  def test_empty_string_returns_zero
    assert_equal 0, @calculator.add("")
  end

   def test_single_number_returns_number
    assert_equal 1, @calculator.add("1")
    assert_equal 5, @calculator.add("5")
  end
  
  def test_two_numbers_comma_separated
    assert_equal 3, @calculator.add("1,2")
    assert_equal 7, @calculator.add("3,4")
  end

  def test_unknown_amount_of_numbers
    assert_equal 6, @calculator.add("1,2,3")
    assert_equal 10, @calculator.add("1,2,3,4")
    assert_equal 15, @calculator.add("1,2,3,4,5")
  end

  def test_new_lines_as_delimiters
    assert_equal 6, @calculator.add("1\n2,3")
    assert_equal 10, @calculator.add("1,2\n3,4")
  end
end
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

  def test_custom_delimiters
    assert_equal 3, @calculator.add("//;\n1;2")
    assert_equal 6, @calculator.add("//|\n1|2|3")
    assert_equal 72, @calculator.add("//:\n12:21:39")
  end

  def test_negative_numbers_throw_exception
    error = assert_raises(RuntimeError) { @calculator.add("-1,2") }
    assert_equal "negatives not allowed: -1", error.message

    error = assert_raises(RuntimeError) { @calculator.add("-1,-2,3") }
    assert_equal "negatives not allowed: -1, -2", error.message
  end

  def test_numbers_greater_than_1000_ignored
    assert_equal 2, @calculator.add("1001,2")
    assert_equal 1, @calculator.add("1001,1,1003")
  end

  def test_single_delimiter_of_any_length
    assert_equal 6, @calculator.add("//[***]\n1***2***3")
  end

  def test_multiple_single_character_delimiters
    assert_equal 6, @calculator.add("//[*][%]\n1*2%3")
  end

  def test_multiple_delimiters_of_different_lengths
    assert_equal 6, @calculator.add("//[**][%%]\n1**2%%3")
  end

  def test_multiple_delimiters_with_longer_lengths
    assert_equal 10, @calculator.add("//[||][###]\n1||2###3||4")
  end

  def test_mixed_delimiter_lengths
    assert_equal 15, @calculator.add("//[*][%%][||]\n1*2%%3||4*5")
  end
end
class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    parsed_numbers = parse_numbers(numbers)
    validate_no_negatives(parsed_numbers)
    sum_valid_numbers(parsed_numbers)
  end

  private

  def parse_numbers(numbers)
    if numbers.start_with?('//')
      parse_custom_delimiter_numbers(numbers)
    else
      parse_default_delimiter_numbers(numbers)
    end
  end

  def parse_custom_delimiter_numbers(numbers)
    delimiter_line, number_string = numbers.split("\n", 2)
    delimiters = extract_delimiters(delimiter_line[2..-1])

    delimiter_regex = delimiters.map { |d| Regexp.escape(d) }.join('|')

    number_string.split(Regexp.new(delimiter_regex))
  end

  def extract_delimiters(delimiter_definition)
    if delimiter_definition.include?('[')
      delimiter_definition.scan(/\[(.+?)\]/).flatten
    else
      [delimiter_definition]
    end
  end

  def parse_default_delimiter_numbers(numbers)
    numbers.split(/[,\n]/)
  end

  def validate_no_negatives(numbers)
    negatives = numbers.select { |n| n.to_i < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
  end

  def sum_valid_numbers(numbers)
    numbers.map(&:to_i).select { |n| n <= 1000 }.sum
  end
end
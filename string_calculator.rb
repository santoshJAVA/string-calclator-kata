class StringCalculator

  def add(numbers)
    return 0 if numbers.empty?

    if numbers.start_with?('//')
      delimiter_line, numbers = numbers.split("\n", 2)
      delimiter = Regexp.escape(delimiter_line[2..-1])
      num_array = numbers.split(Regexp.new(delimiter))
    else
      num_array = numbers.split(/[,\n]/)
    end

    negatives = num_array.select { |n| n.to_i < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?

    num_array.map(&:to_i).select { |n| n <= 1000 }.sum
  end
end
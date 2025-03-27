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

    num_array.map(&:to_i).sum
  end
end
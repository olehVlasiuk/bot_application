class InputReader
  def read(welcome_message: nil, validator: nil, error_message: nil, process: nil)
    puts welcome_message if welcome_message

    loop do
      input = gets.chomp

      input = process.call(input) if process

      if validator && !validator.call(input)
        puts error_message if error_message
        next
      end

      return input
    end
  end
end

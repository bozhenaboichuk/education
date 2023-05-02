class PolishCalculator
  def calculate(expression)
    stack = []
    results = []
    expression.split.each do |token|
      case token
      when '*', '/'
        operand2 = stack.pop
        operand1 = stack.pop
        case token
        when '*'
          result = operand1.to_f * operand2.to_f
        when '/'
          result = operand1.to_f / operand2.to_f
        end
        stack.push(result)
        results.push(result)
      else
        if token.to_f.zero?
          puts "Неправильний формат виразу: #{token}"
        else
          stack.push(token.to_f)
        end
      end
    end

    return results
  end

  def run(input_file)
    expression = File.read(input_file)

    results = calculate(expression)

    File.write('output.res', results.join("\n"))
  end
end

calculator = PolishCalculator.new
calculator.run('input.txt')

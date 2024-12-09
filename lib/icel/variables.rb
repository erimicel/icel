module Icel
  module Variables
    def self.assign_variable(interpreter, line)
      name, expression = line.split('=', 2).map(&:strip)
      value = evaluate_expression(interpreter, expression)
      interpreter.variables[name] = value
    end

    def self.evaluate_expression(interpreter, expression)
      # Replace variable names in the expression with their values
      expression = expression.gsub(/\b\w+\b/) do |word|
        if interpreter.variables.key?(word)
          interpreter.variables[word]
        else
          word
        end
      end

      # Evaluate the expression safely
      begin
        Kernel.eval(expression)
      rescue StandardError
        raise "Invalid expression: #{expression}"
      end
    end
  end
end

module Icel
  module Printer
    def self.print_variable(interpreter, line)
      expression = line.sub('print ', '').strip
      value = Variables.evaluate_expression(interpreter, expression)
      puts value
    end
  end
end

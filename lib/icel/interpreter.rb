module Icel
  class Interpreter
    def initialize
      @variables = {} # Store variables and their values
    end

    def eval(input)
      lines = input.lines.map(&:strip).reject(&:empty?) # Clean input
      i = 0

      while i < lines.size
        line = lines[i]

        if line.start_with?('if ')
          i = Conditionals.process_if_block(self, lines, i)
        elsif line.match?(/^\w+\s*=/) # Variable assignment
          Variables.assign_variable(self, line)
        elsif line.start_with?('print ')
          Printer.print_variable(self, line)
        elsif line.start_with?('#') # Comment
          Comments.process_comment(line)
        else
          puts "Unknown command: #{line.inspect}"
        end

        i += 1
      end
    end

    attr_accessor :variables
  end
end

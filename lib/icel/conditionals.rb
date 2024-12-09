module Icel
  module Conditionals
    def self.process_if_block(interpreter, lines, start_index)
      condition_line = lines[start_index]
      condition = condition_line.sub('if ', '').strip
      condition_result = Variables.evaluate_expression(interpreter, condition)

      # If condition is true, execute the 'if' block
      if condition_result
        execute_block(interpreter, lines, start_index + 1, 'else')
      else
        # If condition is false, execute the 'else' block (if present)
        execute_else_block(interpreter, lines, start_index + 1)
      end
    end

    def self.execute_block(interpreter, lines, start_index, block_type)
      i = start_index
      while i < lines.size
        line = lines[i]
        return i if line.strip == 'end' || line.strip == "else" && block_type == 'if'

        interpreter.eval(line)
        i += 1
      end

      raise 'Missing "end" for block'
    end

    def self.execute_else_block(interpreter, lines, start_index)
      i = start_index
      while i < lines.size
        line = lines[i]
        if line.strip == 'end'
          return i
        elsif line.strip == 'else'
          execute_block(interpreter, lines, i + 1, 'else')
          return i
        else
          interpreter.eval(line)
        end
        i += 1
      end

      raise 'Missing "end" for else block'
    end
  end
end

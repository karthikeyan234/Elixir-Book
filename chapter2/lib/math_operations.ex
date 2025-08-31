defmodule MathOperations do
  def add(a, b), do: a + b
  def subtract(a, b), do: a - b

  def operate(func, a, b) do
    func.(a, b)
  end
end

# Usage:
# add_func = fn a, b -> MathOperations.add(a, b) end
# subtract_func = fn a, b -> MathOperations.subtract(a, b) end
# IO.puts(MathOperations.operate(add_func, 5, 3))       # prints "8"
# IO.puts(MathOperations.operate(subtract_func, 5, 3))  # prints "2"

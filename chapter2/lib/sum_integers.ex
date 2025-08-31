defmodule SumIntegers do
  # Formula-based approach: sum of first n positive integers using n(n+1)/2
  def formula_based(n) when n >= 0 do
    div(n * (n + 1), 2)
  end

  # Iterative approach: recursive sum using an accumulator
  def iterative(n) when n >= 0, do: iterative(n, 0)
  defp iterative(0, acc), do: acc
  defp iterative(n, acc) when n > 0 do
    iterative(n - 1, acc + n)
  end
end

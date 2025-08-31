defmodule Math do
  def factorial(0), do: 1  # Base case
  def factorial(n) when n > 0 do
    n * factorial(n - 1)
  end

  # Tail recursive version
  def factorial(n), do: factorial(n, 1)
  defp factorial(0, acc), do: acc
  defp factorial(n, acc) when n > 0 do
    factorial(n - 1, acc * n)
  end
end

defmodule FruitCalculator do
  def total_quantity(fruits) do
    fruits
    |> Enum.map(fn %{quantity: qty} -> qty end)
    |> Enum.sum()
  end
end

defmodule Example do
  def check_number(n) do
    if n > 0 do
      "#{n} is positive"
    else
      "#{n} is not positive"
    end
  end

  def classify(number) do
    case number do
      1 -> "One"
      2 -> "Two"
      _ -> "Other"
    end
  end

  def size(n) do
    cond do
      n > 0 and n <= 10 -> "small"
      n > 10 and n <= 100 -> "medium"
      n > 100 -> "large"
      true -> "invalid"
    end
  end
end

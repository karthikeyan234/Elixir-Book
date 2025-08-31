defmodule AgeProcessor do
  def process([]), do: :done

  def process([{name, age} | tail]) when age >= 18 do
    IO.puts "#{name} is an adult."
    process(tail)
  end

  def process([{name, _age} | tail]) do
    IO.puts "#{name} is a minor."
    process(tail)
  end
end

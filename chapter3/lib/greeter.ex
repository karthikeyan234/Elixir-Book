defmodule Greeter do
  def greet(age) when age < 12 do
    "Hello, kid!"
  end
  def greet(age) when age < 20 do
    "What's up, teen?"
  end
  def greet(age) do
    "Greetings, adult!"
  end
end

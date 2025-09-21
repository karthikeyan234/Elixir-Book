###############################################################
# Chapter 6 Practical Exercises – Solutions
# Mix, Dependencies, Documentation, Testing, and Debugging
###############################################################

# Exercise 1: Using Mix for a New Project
# ---------------------------------------
# Run in terminal:
#   mix new practice_app
#   cd practice_app
#
# Explore the folder structure. The `mix.exs` file defines
# dependencies, application config, and project metadata.

# Example code inside lib/practice_app.ex:
defmodule PracticeApp do
  def hello do
    "Hello, world!"
  end
end

# Run this in IEx:
#   iex -S mix
#   PracticeApp.hello()
# => "Hello, world!"


# Exercise 2: Managing Dependencies
# ---------------------------------
# In mix.exs, add:
#
# defp deps do
#   [
#     {:jason, "~> 1.4"}
#   ]
# end
#
# Then run:
#   mix deps.get
#
# Example usage:
IO.puts Jason.encode!(%{chapter: 6, title: "Mix and Dependencies"})


# Exercise 3: Generating Documentation
# ------------------------------------
# Add module and function docs:
defmodule PracticeApp.Math do
  @moduledoc "Simple math helpers."

  @doc "Adds two numbers."
  def add(a, b), do: a + b
end

# Run:
#   mix docs
# Open `doc/index.html` in browser.


# Exercise 4: Testing with ExUnit
# -------------------------------
# In test/practice_app/math_test.exs:
defmodule PracticeApp.MathTest do
  use ExUnit.Case, async: true
  alias PracticeApp.Math

  test "add/2 returns the sum" do
    assert Math.add(2, 3) == 5
  end
end

# Run:
#   mix test


# Exercise 5: Debugging with IO.inspect/2
# ---------------------------------------
defmodule PracticeApp.Buggy do
  # Intentionally wrong: should sum a list, but multiplies
  def sum_list(list) do
    Enum.reduce(list, 0, fn x, acc ->
      IO.inspect(acc, label: "Accumulator before step")
      IO.inspect(x, label: "Current element")
      acc * x   # Bug: should be acc + x
    end)
  end
end

# Try in IEx:
#   PracticeApp.Buggy.sum_list([1, 2, 3])
# Observe the printed debug output to find the bug.

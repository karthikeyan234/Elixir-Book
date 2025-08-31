defmodule Calculator do
  @moduledoc """
  This module provides basic arithmetic operations.
  """

  @doc """
  Adds two numbers.
  """
  def add(a, b), do: a + b

  @deprecated "Use `subtract/2` instead."
  def minus(a, b), do: a - b

  def subtract(a, b), do: a - b
end

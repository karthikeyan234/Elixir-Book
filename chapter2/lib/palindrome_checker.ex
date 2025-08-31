defmodule PalindromeChecker do
  @moduledoc """
  Checks if a string is a palindrome, ignoring spaces, punctuation, and capitalization.
  """

  def is_palindrome?(str) do
    cleaned_str = clean_string(str)
    cleaned_str == String.reverse(cleaned_str)
  end

  defp clean_string(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
  end
end

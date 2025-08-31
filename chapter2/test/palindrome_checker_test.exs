defmodule PalindromeCheckerTest do
  use ExUnit.Case
  alias PalindromeChecker

  describe "is_palindrome?/1" do
    test "checks if a string is a palindrome, ignoring spaces, punctuation, and capitalization" do
      assert PalindromeChecker.is_palindrome?("A man, a plan, a canal, Panama")
      assert PalindromeChecker.is_palindrome?("Madam")
      assert PalindromeChecker.is_palindrome?("Racecar")
      assert not PalindromeChecker.is_palindrome?("Hello")
      assert not PalindromeChecker.is_palindrome?("Elixir")
    end

    test "returns true for empty string and single-letter strings" do
      assert PalindromeChecker.is_palindrome?("")
      assert PalindromeChecker.is_palindrome?("a")
      assert PalindromeChecker.is_palindrome?("A")
    end
  end
end

defmodule SumIntegersTest do
  use ExUnit.Case
  alias SumIntegers

  describe "formula_based/1" do
    test "calculate sum of n integers correctly" do
      assert SumIntegers.formula_based(0) == 0
      assert SumIntegers.formula_based(1) == 1
      assert SumIntegers.formula_based(5) == 15
      assert SumIntegers.formula_based(10) == 55
    end
  end

  describe "iterative/1" do
    test "calculates sum of first n integers correctly" do
      assert SumIntegers.iterative(0) == 0
      assert SumIntegers.iterative(1) == 1
      assert SumIntegers.iterative(5) == 15
      assert SumIntegers.iterative(10) == 55
    end
  end
end

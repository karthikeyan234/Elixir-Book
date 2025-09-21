###############################################################
# Chapter 7 Practical Exercises – Solutions
# Metaprogramming with Macros
###############################################################

# =============================================================
# Exercise 1: Create a Custom Assertion Macro
# Objective:
#   Define a macro `assert_equal` that compares expected and actual values.
#   If they are not equal, raise an error with a clear message.
# =============================================================

defmodule MyAssertions do
  defmacro assert_equal(expected, actual) do
    quote do
      unless unquote(expected) == unquote(actual) do
        raise "Assertion failed! Expected: #{inspect(unquote(expected))}, " <>
              "but got: #{inspect(unquote(actual))}"
      end
    end
  end
end

defmodule TestModule do
  require MyAssertions

  def check_assertions do
    MyAssertions.assert_equal(1 + 1, 2)   # ✅ Passes
    MyAssertions.assert_equal(3 * 3, 10)  # ❌ Fails with assertion error
  end
end

# Try it in IEx:
#   TestModule.check_assertions()
# You will see one pass silently, and one raise an error message.


# =============================================================
# Exercise 2: Macro for Logging Execution Time
# Objective:
#   Create a macro `log_execution` that logs how long a function call took.
# =============================================================

defmodule ExecutionLogger do
  defmacro log_execution(func) do
    quote do
      start_time = :erlang.monotonic_time()
      result = unquote(func)
      end_time = :erlang.monotonic_time()

      IO.puts("Function executed in #{end_time - start_time} nanoseconds")

      result
    end
  end
end

defmodule Usage do
  require ExecutionLogger

  def slow_function do
    :timer.sleep(1000)
    "Done"
  end

  def test_logging do
    ExecutionLogger.log_execution(slow_function())
  end
end

# Try it in IEx:
#   Usage.test_logging()
# Output:
#   "Function executed in <time> nanoseconds"
#   "Done"

defmodule Chapter4.CounterTest do
  use ExUnit.Case, async: true
  alias Chapter4.GenServer.Counter

  test "counter increments/decrements/get/reset" do
    {:ok, pid} = Counter.start_link(5)
    assert 5 == Counter.get(pid)
    :ok = Counter.increment(pid)
    :ok = Counter.increment(pid)
    :ok = Counter.decrement(pid)
    assert 6 == Counter.get(pid)
    assert 0 == Counter.reset(pid)
    assert 0 == Counter.get(pid)
  end
end

defmodule MyDistributedApp.CounterTest do
  use ExUnit.Case, async: true

  setup do
    # Start a fresh isolated instance per test (not globally registered)
    {:ok, pid} = GenServer.start_link(MyDistributedApp.Counter, 10)
    %{pid: pid}
  end

  test "get, increment, decrement, reset using local pid", %{pid: pid} do
    assert GenServer.call(pid, :get_count) == 10
    :ok = GenServer.cast(pid, :increment)
    :ok = GenServer.cast(pid, :increment)
    :ok = GenServer.cast(pid, :decrement)
    # Give casts a tick to process
    Process.sleep(10)
    assert GenServer.call(pid, :get_count) == 11
    assert GenServer.call(pid, :reset) == 0
    assert GenServer.call(pid, :get_count) == 0
  end
end

defmodule Chapter4.SupervisionTest do
  use ExUnit.Case

  alias Chapter4.Supervision.{SuperTree, DynamicTree}
  alias Chapter4.GenServer.Counter

  test "static supervisor starts counter and agent" do
    {:ok, _sup} = SuperTree.start_link()
    assert is_pid(Process.whereis(Chapter4.Counter))
    Agent.update(Chapter4.KV, &Map.put(&1, :a, 1))
    assert 1 == Agent.get(Chapter4.KV, & &1[:a])
    assert 0 == Counter.get(Chapter4.Counter)
  end

  test "dynamic supervisor starts jobs and registers them" do
    {:ok, _dyn} = DynamicTree.start_link()
    {:ok, _} = DynamicTree.start_job(:success, 1)
    assert [{_, pid, :worker, _}] = DynamicTree.which_children()
    assert is_pid(pid)
  end
end

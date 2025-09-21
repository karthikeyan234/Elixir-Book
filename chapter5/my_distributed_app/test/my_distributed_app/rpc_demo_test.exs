defmodule MyDistributedApp.RPCDemoTest do
  use ExUnit.Case

  test ":rpc.call to local node works against a globally registered counter" do
    # Ensure a global Counter is running (ok if it was already started by the app)
    case MyDistributedApp.Counter.start_link(42) do
      {:ok, _pid} -> :ok
      {:error, {:already_started, _pid}} -> :ok
    end

    node_name = node()  # works even if :nonode@nohost

    base = :rpc.call(node_name, MyDistributedApp.Counter, :get_count, [])
    assert is_integer(base)

    # Increment via RPC and verify
    assert :ok == :rpc.call(node_name, MyDistributedApp.Counter, :increment, [])
    Process.sleep(10)

    assert base + 1 == :rpc.call(node_name, MyDistributedApp.Counter, :get_count, [])
  end
end

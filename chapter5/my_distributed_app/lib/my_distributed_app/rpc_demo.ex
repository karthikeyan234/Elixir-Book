defmodule MyDistributedApp.RPCDemo do
  @moduledoc """
  Small helpers that show inter-node communication.

  * `connect/1` – connect to a node by name (returns true/false).
  * `remote_get/1` – get the counter value from a given node via :rpc.call/4.
  * `remote_inc/1` – increment the counter on a given node via :rpc.call/4.
  """

  @doc """
  Connect to another node by atom name, e.g. :node2@hostname
  """
  def connect(node_name) when is_atom(node_name), do: Node.connect(node_name)

  @doc """
  Get the counter value from a remote node (requires that node to run the app).
  """
  def remote_get(node_name) when is_atom(node_name) do
    :rpc.call(node_name, MyDistributedApp.Counter, :get_count, [])
  end

  @doc """
  Increment the counter on a remote node.
  """
  def remote_inc(node_name) when is_atom(node_name) do
    :rpc.call(node_name, MyDistributedApp.Counter, :increment, [])
  end
end

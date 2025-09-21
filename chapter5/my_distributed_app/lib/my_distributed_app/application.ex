defmodule MyDistributedApp.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children =
      cluster_children() ++ [
        {MyDistributedApp.Counter, 0}
      ]

    opts = [strategy: :one_for_one, name: MyDistributedApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp cluster_children do
    # If there is no config folder, this returns nil — coerce to []
    topologies = Application.get_env(:my_distributed_app, :cluster_topologies) || []

    case {Code.ensure_loaded?(Cluster.Supervisor), topologies} do
      {true, [_ | _]} ->
        [{Cluster.Supervisor, [topologies, [name: MyDistributedApp.ClusterSupervisor]]}]

      _ ->
        []  # No clustering unless explicitly configured
    end
  end
end

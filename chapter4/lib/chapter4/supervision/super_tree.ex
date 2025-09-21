defmodule Chapter4.Supervision.SuperTree do
  @moduledoc """
  A static supervision tree that supervises a Counter and an Agent.
  """

  use Supervisor

  alias Chapter4.GenServer.Counter

  def start_link(init_arg \\ :ok, opts \\ []) do
    Supervisor.start_link(__MODULE__, init_arg, Keyword.put_new(opts, :name, __MODULE__))
  end

  @impl true
  def init(:ok) do
    children = [
      {Counter, {0, [name: Chapter4.Counter]}},
      %{
        id: :kv_agent,
        start: {Agent, :start_link, [fn -> %{} end, [name: Chapter4.KV]]},
        type: :worker,
        restart: :permanent
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

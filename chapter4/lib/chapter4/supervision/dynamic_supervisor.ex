defmodule Chapter4.Supervision.BackgroundJob do
  @moduledoc """
  A worker started under a DynamicSupervisor.
  """
  use GenServer

  def start_link(%{id: id} = opts) do
    GenServer.start_link(__MODULE__, opts, name: via(id))
  end

  def whereis(id), do: GenServer.whereis(via(id))

  defp via(id), do: {:via, Registry, {Chapter4.Registry, {:job, id}}}

  @impl true
  def init(%{id: id, type: type}) do
    Process.flag(:trap_exit, true)
    send(self(), {:run, type})
    {:ok, %{id: id, type: type}}
  end

  @impl true
  def handle_info({:run, :success}, state) do
    # Simulate work
    :timer.sleep(100)
    {:noreply, state}
  end

  def handle_info({:run, :fail}, state) do
    # Crash intentionally to show restart behavior
    raise "BackgroundJob #{inspect(state.id)} failed"
  end

  def handle_info(msg, state) do
    IO.inspect(msg, label: "BackgroundJob (ignored)")
    {:noreply, state}
  end
end

defmodule Chapter4.Supervision.DynamicTree do
  @moduledoc """
  DynamicSupervisor + Registry to start/lookup jobs at runtime.
  """

  use DynamicSupervisor

  def start_link(_init \\ :ok, opts \\ []) do
    DynamicSupervisor.start_link(__MODULE__, :ok, Keyword.put_new(opts, :name, __MODULE__))
  end

  @impl true
  def init(:ok) do
    Registry.start_link(keys: :unique, name: Chapter4.Registry)
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_job(type, id) do
    spec = {Chapter4.Supervision.BackgroundJob, %{type: type, id: id}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def which_children do
    DynamicSupervisor.which_children(__MODULE__)
  end
end

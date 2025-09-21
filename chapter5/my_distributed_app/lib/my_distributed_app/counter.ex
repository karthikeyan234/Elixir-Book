defmodule MyDistributedApp.Counter do
  @moduledoc """
  Distributed counter served by a GenServer. It registers itself globally so that any
  connected node can call it via `{:global, __MODULE__}`.

  Public API:
    start_link/1
    get_count/0
    increment/0
    decrement/0
    reset/0
  """

  use GenServer

  # ===== Public API =====

  def start_link(initial_count \\ 0) when is_integer(initial_count) do
    GenServer.start_link(__MODULE__, initial_count, name: {:global, __MODULE__})
  end

  def get_count do
    GenServer.call({:global, __MODULE__}, :get_count)
  end

  def reset do
    GenServer.call({:global, __MODULE__}, :reset)
  end

  def increment do
    GenServer.cast({:global, __MODULE__}, :increment)
  end

  def decrement do
    GenServer.cast({:global, __MODULE__}, :decrement)
  end

  # ===== GenServer callbacks =====

  @impl true
  def init(initial_count) when is_integer(initial_count), do: {:ok, initial_count}

  @impl true
  def handle_call(:get_count, _from, count), do: {:reply, count, count}

  @impl true
  def handle_call(:reset, _from, _count), do: {:reply, 0, 0}

  @impl true
  def handle_cast(:increment, count), do: {:noreply, count + 1}

  @impl true
  def handle_cast(:decrement, count), do: {:noreply, count - 1}

  @impl true
  def handle_info(msg, state) do
    # Swallow stray messages so we never crash unexpectedly
    IO.inspect(msg, label: "Counter.handle_info/2 (ignored)")
    {:noreply, state}
  end
end

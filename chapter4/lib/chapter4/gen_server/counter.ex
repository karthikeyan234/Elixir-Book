defmodule Chapter4.GenServer.Counter do
  @moduledoc """
  A simple counter with synchronous and asynchronous APIs.

  Public functions:
    start_link/1, get/1, increment/1, decrement/1, reset/1
  """

  use GenServer

  # Public API

  def start_link(initial \\ 0, opts \\ []) do
    # Support being started both directly as start_link(initial, opts)
    # and via a supervisor child-spec of the form {Module, {initial, opts}}
    case initial do
      {init, start_opts} -> GenServer.start_link(__MODULE__, init, start_opts)
      _ -> GenServer.start_link(__MODULE__, initial, opts)
    end
  end

  def get(server), do: GenServer.call(server, :get)
  def reset(server), do: GenServer.call(server, :reset)
  def increment(server), do: GenServer.cast(server, :inc)
  def decrement(server), do: GenServer.cast(server, :dec)

  # GenServer callbacks

  @impl true
  def init(initial) when is_integer(initial), do: {:ok, initial}

  @impl true
  def handle_call(:get, _from, state), do: {:reply, state, state}

  @impl true
  def handle_call(:reset, _from, _state), do: {:reply, 0, 0}

  @impl true
  def handle_cast(:inc, state), do: {:noreply, state + 1}

  @impl true
  def handle_cast(:dec, state), do: {:noreply, state - 1}

  @impl true
  def handle_info(msg, state) do
    # Handle stray messages without crashing
    IO.inspect(msg, label: "Counter.handle_info/2 (ignored)")
    {:noreply, state}
  end
end

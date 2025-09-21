defmodule Chapter4.FaultTolerance do
  @moduledoc """
  Links, monitors, and trapping exits.
  """

  def link_example do
    parent = self()

    child =
      spawn_link(fn ->
        send(parent, :child_started)
        # crash
        raise "boom"
      end)

    receive do
      :child_started -> :ok
    after
      1_000 -> {:error, :child_never_started}
    end

    # If not trapping exits, the linked crash will kill the parent too.
    # So provide a safe variant:
    {child, :linked}
  end

  def trap_exit_example do
    Process.flag(:trap_exit, true)
    parent = self()

    child =
      spawn_link(fn ->
        send(parent, :child_started)
        exit(:shutdown)
      end)

    receive do
      :child_started -> :ok
    after
      1_000 -> {:error, :child_never_started}
    end

    receive do
      {:EXIT, ^child, :shutdown} -> :trapped
    after
      1_000 -> {:error, :no_exit_message}
    end
  end

  def monitor_example do
    parent = self()

    child =
      spawn(fn ->
        send(parent, :child_started)
        exit(:normal)
      end)

    ref = Process.monitor(child)

    receive do
      :child_started -> :ok
    after
      1_000 -> {:error, :child_never_started}
    end

    receive do
      {:DOWN, ^ref, :process, ^child, :normal} -> :down_normal
    after
      1_000 -> {:error, :no_down_message}
    end
  end
end

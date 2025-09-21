defmodule Chapter4.Processes.MyModule do
  @moduledoc """
  Minimal process demo.
  """

  def say_hello do
    IO.puts("Hello, World!")
  end

  def spawn_hello do
    spawn(__MODULE__, :say_hello, [])
  end
end

defmodule Chapter4.Processes.Communicator do
  @moduledoc """
  Send/receive demonstration with acknowledgements.
  """

  # Public API

  @doc """
  Spawns a receiver and returns its pid.
  """
  def start_receiver do
    spawn(__MODULE__, :receive_loop, [])
  end

  @doc """
  Send a message to `pid` and wait for an ack from that process.
  Returns {:ok, ack_msg}.
  """
  def send_message(pid, msg) when is_pid(pid) do
    send(pid, {:my_message, self(), msg})

    receive do
      {:ack, ^pid, ack_msg} -> {:ok, ack_msg}
    after
      2_000 -> {:error, :timeout}
    end
  end

  # Process loop

  @doc false
  def receive_loop do
    receive do
      {:my_message, sender_pid, msg} ->
        # Reply back (ack)
        send(sender_pid, {:ack, self(), "Message received: #{msg}"})
        receive_loop()
      other ->
        IO.inspect({:ignored, other}, label: "Communicator")
        receive_loop()
    after
      10_000 ->
        # exit after idle
        :ok
    end
  end
end

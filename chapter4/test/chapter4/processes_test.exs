defmodule Chapter4.ProcessesTest do
  use ExUnit.Case, async: true

  alias Chapter4.Processes.{MyModule, Communicator}

  test "spawn hello prints" do
    assert is_pid(MyModule.spawn_hello())
  end

  test "send/receive with ack" do
    pid = Communicator.start_receiver()
    assert {:ok, "Message received: hi"} = Communicator.send_message(pid, "hi")
  end
end

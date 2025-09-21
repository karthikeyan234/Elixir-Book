defmodule Chapter4.TaskExamplesTest do
  use ExUnit.Case

  alias Chapter4.TaskExamples.{BasicTask, Supervised}

  test "basic task runs and returns :done" do
    assert :done == BasicTask.run()
  end

  test "supervised task returns value" do
    {:ok, _} = Supervised.start_supervisor()
    assert 42 == Supervised.run_job(fn -> 40 + 2 end)
  end
end

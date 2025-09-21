defmodule Chapter4.TaskExamples.BasicTask do
  @moduledoc """
  Basic Task.async/await example with timeout handling.
  """

  def long_running_task do
    :timer.sleep(3000)
    :done
  end

  def run do
    task = Task.async(fn -> long_running_task() end)

    try do
      Task.await(task, 3_500)
    catch
      :exit, {:timeout, _} ->
        :timeout
    end
  end
end

defmodule Chapter4.TaskExamples.Supervised do
  @moduledoc """
  Using Task.Supervisor to run tasks under supervision.
  """

  def start_supervisor do
    Task.Supervisor.start_link(name: Chapter4.TaskSup)
  end

  def run_job(fun) when is_function(fun, 0) do
    Task.Supervisor.async_nolink(Chapter4.TaskSup, fun)
    |> Task.await(2_000)
  end
end

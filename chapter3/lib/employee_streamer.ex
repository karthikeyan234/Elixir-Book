defmodule EmployeeStreamer do
  def lazy_salary_increase(employees) do
    Stream.map(employees, fn %{salary: salary} = employee ->
      Map.update!(employee, :salary, &(&1 + &1 * 0.1))
    end)
  end

  def stream_engineering(employees) do
    employees
    |> Stream.filter(fn %{department: dept} -> dept == "Engineering" end)
  end

  def stream_transform(employees) do
    employees
    |> Stream.filter(fn %{department: dept} -> dept == "Engineering" end)
    |> Stream.map(fn %{name: name} -> "Engineer: #{name}" end)
  end

  def large_dataset_stream() do
    1..1_000_000
    |> Stream.map(fn x -> x * 2 end)
    |> Stream.filter(fn x -> rem(x, 3) == 0 end)
  end
end

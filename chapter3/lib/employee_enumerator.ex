defmodule EmployeeEnumerator do
  def print_names(employees) do
    Enum.each(employees, fn %{name: name} -> IO.puts(name) end)
  end

  def log_salaries(employees) do
    Enum.each(employees, fn %{name: name, salary: salary} ->
      IO.inspect("#{name}'s salary: $#{salary}")
    end)
  end

  def list_all_projects(employees) do
    Enum.each(employees, fn %{name: name, projects: projects} ->
      IO.puts("#{name} is working on: #{Enum.join(projects, ", ")}")
    end)
  end
end

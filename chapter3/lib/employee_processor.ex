defmodule EmployeeProcessor do
  def raise_salaries(employees) do
    Enum.map(employees, fn employee ->
      Map.update!(employee, :salary, &(&1 * 1.1))
    end)
  end

  def get_employee_names(employees) do
    Enum.map_join(employees, ", ", fn %{name: name} -> name end)
  end

  def get_all_projects(employees) do
    Enum.flat_map(employees, fn %{projects: projects} -> projects end)
  end

  def names_and_total_salary(employees) do
    Enum.map_reduce(employees, 0, fn employee, acc ->
      {employee.name, employee.salary + acc}
    end)
  end

  def unique_projects_count(employees) do
    Enum.flat_map_reduce(employees, [], fn %{projects: projects}, acc ->
      {projects, acc ++ projects}
    end)
    |> then(fn {projects, _all_projects} -> {Enum.uniq(projects), length(projects)} end)
  end
end

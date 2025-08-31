defmodule EmployeeCombiner do
  def combine_employees(existing_employees, new_employees) do
    Enum.concat(existing_employees, new_employees)
  end

  def all_projects(employees) do
    employees
    |> Enum.flat_map(fn %{projects: projects} -> projects end)
    |> Enum.uniq()
  end

  def combine_and_transform(employees, departments) do
    employees
    |> Enum.map(fn %{name: name, department: dept} ->
      department_name = departments[dept]
      "#{name} (#{department_name})"
    end)
  end

  def zip_names_and_salaries(employees) do
    names = Enum.map(employees, fn %{name: name} -> name end)
    salaries = Enum.map(employees, fn %{salary: salary} -> salary end)
    Enum.zip(names, salaries)
  end
end

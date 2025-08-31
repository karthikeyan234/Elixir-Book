defmodule EmployeeFilter do
  def within_salary_range(employees, min_salary, max_salary) do
    Enum.filter(employees, fn %{salary: salary} -> salary >= min_salary and salary <= max_salary end)
  end

  def without_projects(employees) do
    Enum.filter(employees, fn %{projects: projects} -> projects == [] end)
  end

  def names_from_department(employees, target_department) do
    employees
    |> Enum.filter(fn %{department: dept} -> dept == target_department end)
    |> Enum.map(fn %{name: name} -> name end)
  end
end

defmodule EmployeeGrouper do
  def group_by_department(employees) do
    Enum.group_by(employees, fn %{department: dept} -> dept end)
  end

  def group_by_projects(employees) do
    employees
    |> Enum.flat_map(fn %{name: name, projects: projects} -> Enum.map(projects, fn project -> {project, name} end) end)
    |> Enum.group_by(fn {project, _name} -> project end, fn {_project, name} -> name end)
  end

  def count_employees_by_department(employees) do
    Enum.group_by(employees, fn %{department: dept} -> dept end)
    |> Enum.map(fn {dept, emps} -> {dept, length(emps)} end)
  end

  def group_by_salary_range(employees, range_size) do
    Enum.group_by(employees, fn %{salary: salary} -> div(salary, range_size) * range_size end)
  end
end

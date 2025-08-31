defmodule EmployeeFinder do
  def find_by_name(employees, target_name) do
    Enum.find(employees, fn %{name: name} -> name == target_name end)
  end

  def find_in_department(employees, target_department) do
    Enum.filter(employees, fn %{department: dept} -> dept == target_department end)
  end

  def highest_paid_employee(employees) do
    Enum.max_by(employees, fn %{salary: salary} -> salary end)
  end

  def find_with_project_experience(employees, project_name) do
    Enum.filter(employees, fn %{projects: projects} -> project_name in projects end)
  end
end

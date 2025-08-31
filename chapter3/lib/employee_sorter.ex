defmodule EmployeeSorter do
  def sort_by_name(employees) do
    Enum.sort_by(employees, &(&1.name))
  end

  def sort_by_salary_desc(employees) do
    Enum.sort_by(employees, &(&1.salary), &>=/2)
  end

  def sort_by_department_and_name(employees) do
    Enum.sort_by(employees, &[&1.department, &1.name])
  end

  def sort_by_project_count(employees) do
    Enum.sort_by(employees, fn %{projects: projects} -> length(projects) end, :desc)
  end
end

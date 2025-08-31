defmodule EmployeeAnalytics do
  def total_salary(employees) do
    Enum.reduce(employees, 0, fn %{salary: salary}, acc -> acc + salary end)
  end

  def average_salary(employees) do
    total_salary = EmployeeAnalytics.total_salary(employees)
    Enum.count(employees) |> then(fn count -> total_salary / count end)
  end

  def total_experience_in_department(employees, department) do
    employees
    |> Enum.filter(fn %{department: d} -> d == department end)
    |> Enum.reduce(0, fn %{years_of_experience: exp}, acc -> acc + exp end)
  end

  def average_experience_per_department(employees) do
    employees
    |> Enum.group_by(fn %{department: dept} -> dept end)
    |> Enum.map(fn {dept, emps} ->
      total_exp = Enum.reduce(emps, 0, fn %{years_of_experience: exp}, acc -> acc + exp end)
      {dept, total_exp / length(emps)}
    end)
  end
end

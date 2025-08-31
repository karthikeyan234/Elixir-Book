defmodule EmployeeReducer do
  def total_salary(employees) do
    Enum.reduce(employees, 0, fn %{salary: salary}, acc -> acc + salary end)
  end

  def max_experience(employees) do
    Enum.reduce(employees, 0, fn %{years_of_experience: exp}, acc -> max(exp, acc) end)
  end

  def department_summary(employees) do
    Enum.reduce(employees, %{}, fn %{department: dept, salary: salary, years_of_experience: exp}, acc ->
      dept_info = acc[dept] || %{total_salary: 0, total_experience: 0, count: 0}
      new_total_salary = dept_info.total_salary + salary
      new_total_experience = dept_info.total_experience + exp
      new_count = dept_info.count + 1
      Map.put(acc, dept, %{total_salary: new_total_salary, total_experience: new_total_experience, count: new_count})
    end)
    |> Enum.map(fn {dept, %{total_salary: total_salary, total_experience: total_experience, count: count}} ->
      %{department: dept, total_salary: total_salary, average_experience: total_experience / count}
    end)
  end

  def weighted_average_salary(employees) do
    total_exp = Enum.reduce(employees, 0, fn %{years_of_experience: exp}, acc -> acc + exp end)
    Enum.reduce(employees, 0, fn %{salary: salary, years_of_experience: exp}, acc -> acc + salary * exp end) / total_exp
  end
end

defmodule Chapter3Exercises do
  # Exercise 1: Most frequent department
  def most_frequent_department(employees) do
    employees
    |> Enum.map(& &1.department)
    |> Enum.frequencies()
    |> Enum.max_by(fn {_dept, count} -> count end)
  end

  # Exercise 2: Names in department
  def names_in_department(employees, dept) do
    employees
    |> Enum.filter(&(&1.department == dept))
    |> Enum.map(& &1.name)
  end

  # Exercise 3: Summarize salaries by department
  def summarize_salaries_by_department(employees) do
    employees
    |> Enum.group_by(& &1.department)
    |> Enum.map(fn {dept, emps} ->
      {dept, Enum.reduce(emps, 0, fn %{salary: s}, acc -> acc + s end)}
    end)
  end

  # Exercise 4: Unique projects
  def unique_projects(employees) do
    employees
    |> Enum.flat_map(& &1.projects)
    |> Enum.uniq()
  end

  # Exercise 5: Sequential salary differences
  def sequential_salary_differences(employees) do
    employees
    |> Enum.map(& &1.salary)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [first, second] -> abs(second - first) end)
  end
end

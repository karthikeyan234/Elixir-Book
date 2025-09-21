defmodule LibUnitsTest do
  use ExUnit.Case

  test "Math.factorial works (recursive and tail)" do
    assert Math.factorial(0) == 1
    assert Math.factorial(1) == 1
    assert Math.factorial(5) == 120
  end

  test "Greeter.greet branches by age" do
    assert Greeter.greet(5) == "Hello, kid!"
    assert Greeter.greet(15) == "What's up, teen?"
    assert Greeter.greet(30) == "Greetings, adult!"
  end

  test "ListOperations.sum handles lists" do
    assert ListOperations.sum([]) == 0
    assert ListOperations.sum([1,2,3,4]) == 10
  end

  test "FruitCalculator.total_quantity sums quantities" do
    fruits = [%{name: "apple", quantity: 3}, %{name: "banana", quantity: 2}]
    assert FruitCalculator.total_quantity(fruits) == 5
  end

  test "EmployeeFilter functions" do
    emps = [
      %{name: "A", salary: 100, projects: [], department: :dev},
      %{name: "B", salary: 200, projects: [1], department: :hr}
    ]

    assert EmployeeFilter.within_salary_range(emps, 50, 150) == [%{name: "A", salary: 100, projects: [], department: :dev}]
    assert EmployeeFilter.without_projects(emps) == [%{name: "A", salary: 100, projects: [], department: :dev}]
    assert EmployeeFilter.names_from_department(emps, :hr) == ["B"]
  end

  test "EmployeeSorter functions" do
    emps = [
      %{name: "Charlie", salary: 300, department: :dev, projects: [1,2]},
      %{name: "Alice", salary: 500, department: :hr, projects: []},
      %{name: "Bob", salary: 400, department: :dev, projects: [3]}
    ]

    assert Enum.map(EmployeeSorter.sort_by_name(emps), & &1.name) == ["Alice","Bob","Charlie"]
    assert Enum.map(EmployeeSorter.sort_by_salary_desc(emps), & &1.salary) == [500,400,300]
  # sort_by_department_and_name sorts by department first, then name
  assert Enum.map(EmployeeSorter.sort_by_department_and_name(emps), & &1.name) == ["Bob","Charlie","Alice"]
    assert Enum.map(EmployeeSorter.sort_by_project_count(emps), & &1.name) == ["Charlie","Bob","Alice"]
  end

  test "EmployeeAnalytics functions" do
    emps = [
      %{name: "A", salary: 100, department: :dev, years_of_experience: 2},
      %{name: "B", salary: 200, department: :dev, years_of_experience: 3},
      %{name: "C", salary: 300, department: :hr, years_of_experience: 5}
    ]

    assert EmployeeAnalytics.total_salary(emps) == 600
    assert EmployeeAnalytics.average_salary(emps) == 200.0
    assert EmployeeAnalytics.total_experience_in_department(emps, :dev) == 5

    avg = EmployeeAnalytics.average_experience_per_department(emps) |> Enum.into(%{})
    assert Float.round(avg[:dev], 6) == 2.5
    assert Float.round(avg[:hr], 6) == 5.0
  end

  test "EmployeeCombiner functions" do
    emps1 = [%{name: "A", projects: [1], salary: 100, department: :dev}]
    emps2 = [%{name: "B", projects: [2,3], salary: 200, department: :hr}]

    assert EmployeeCombiner.combine_employees(emps1, emps2) == emps1 ++ emps2
    assert EmployeeCombiner.all_projects(emps1 ++ emps2) == [1,2,3]

    departments = %{dev: "Development", hr: "Human Resources"}
    assert EmployeeCombiner.combine_and_transform(emps1 ++ emps2, departments) == ["A (Development)", "B (Human Resources)"]
    assert EmployeeCombiner.zip_names_and_salaries(emps1 ++ emps2) == [{"A",100},{"B",200}]
  end
end

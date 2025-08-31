defmodule StudentProcessor do
  def filter_and_sort(students) do
    students
    |> Enum.filter(fn {_name, score} -> score >= 50 end)
    |> Enum.sort_by(fn {_name, score} -> score end)
  end
end

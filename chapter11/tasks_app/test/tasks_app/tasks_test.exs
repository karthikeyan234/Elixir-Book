defmodule TasksApp.TasksTest do
  use TasksApp.DataCase

  alias TasksApp.Tasks
  alias TasksApp.Tasks.Task

  @valid_attrs %{title: "Task 1", description: "Do something"}
  @invalid_attrs %{title: nil}

  test "list_tasks/0 returns all tasks" do
    task = task_fixture()
    assert Tasks.list_tasks() == [task]
  end

  test "get_task!/1 returns the task by id" do
    task = task_fixture()
    assert Tasks.get_task!(task.id) == task
  end

  test "create_task/1 with valid data creates task" do
    assert {:ok, %Task{} = task} = Tasks.create_task(@valid_attrs)
    assert task.title == "Task 1"
  end

  test "create_task/1 with invalid data returns error changeset" do
    assert {:error, changeset} = Tasks.create_task(@invalid_attrs)
    assert %{title: ["can't be blank"]} = errors_on(changeset)
  end

  test "update_task/2 updates the task" do
    task = task_fixture()
    update_attrs = %{title: "Updated Task"}

    assert {:ok, %Task{} = updated_task} = Tasks.update_task(task, update_attrs)
    assert updated_task.title == "Updated Task"
  end

  test "delete_task/1 deletes the task" do
    task = task_fixture()
    assert {:ok, %Task{}} = Tasks.delete_task(task)
    assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
  end

  defp task_fixture(attrs \\ %{}) do
    attrs = Enum.into(attrs, @valid_attrs)
    {:ok, task} = Tasks.create_task(attrs)
    task
  end
end

defmodule TasksAppWeb.TaskControllerTest do
  use TasksAppWeb.ConnCase

  alias TasksApp.Tasks

  @valid_attrs %{title: "Task 1", description: "Do this task"}
  @invalid_attrs %{title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "text/html")}
  end

  test "GET /tasks", %{conn: conn} do
    conn = get(conn, ~p"/tasks")
    assert html_response(conn, 200) =~ "Listing Tasks"
  end

  test "POST /tasks creates task", %{conn: conn} do
    conn = post(conn, ~p"/tasks", task: @valid_attrs)
    assert redirected_to(conn) =~ "/tasks/"
  end

  test "GET /tasks/new renders form", %{conn: conn} do
    conn = get(conn, ~p"/tasks/new")
    assert html_response(conn, 200) =~ "New Task"
  end

  test "GET /tasks/:id shows chosen task", %{conn: conn} do
    {:ok, task} = Tasks.create_task(@valid_attrs)
    conn = get(conn, ~p"/tasks/#{task.id}")
    assert html_response(conn, 200) =~ task.title
  end

  test "GET /tasks/:id/edit renders edit form", %{conn: conn} do
    {:ok, task} = Tasks.create_task(@valid_attrs)
    conn = get(conn, ~p"/tasks/#{task.id}/edit")
    assert html_response(conn, 200) =~ "Edit Task"
  end

  test "DELETE /tasks/:id deletes the task and redirects", %{conn: conn} do
    {:ok, task} = Tasks.create_task(@valid_attrs)
    conn = delete(conn, ~p"/tasks/#{task.id}")
    assert redirected_to(conn) == ~p"/tasks"
    assert_error_sent 404, fn ->
      get(conn, ~p"/tasks/#{task.id}")
    end
  end
end

defmodule TasksApp.Repo do
  use Ecto.Repo,
    otp_app: :tasks_app,
    adapter: Ecto.Adapters.Postgres
end

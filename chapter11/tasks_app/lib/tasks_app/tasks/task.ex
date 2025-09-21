defmodule TasksApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tasks" do
    field :title, :string
    field :description, :string

    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description])
    |> validate_required([:title])
  end
end

# tasks_app_web/components/task_components.ex
defmodule TasksAppWeb.TaskComponents do
  use Phoenix.Component
  # Phoenix.VerifiedRoutes not needed in these components

  attr :title, :string, required: true
  attr :subtitle, :string, default: nil

  def form_header(assigns) do
    ~H"""
    <div class="border-b border-gray-200 pb-4 mb-4">
      <h2 class="text-xl font-bold">{@title}</h2>
      <%= if @subtitle do %>
        <p class="text-sm text-gray-500">{@subtitle}</p>
      <% end %>
    </div>
    """
  end

  attr :task, :map, required: true

  def task_card(assigns) do
    ~H"""
    <div class="border rounded p-4 mb-4">
      <h2>{@task.title}</h2>
      <p>{@task.description}</p>
    </div>
    """
  end

  attr :task, :map, required: true
  attr :edit_path, :string, required: true
  attr :show_path, :string, required: true
  attr :delete_path, :string, required: true

  def task_row(assigns) do
    ~H"""
    <div class="flex items-center justify-between border rounded px-4 py-3 mb-3 bg-white shadow-sm">
      <div>
        <div class="font-semibold"><%= @task.title %></div>
        <div class="text-sm text-gray-500"><%= @task.description %></div>
      </div>
      <div class="flex gap-3">
        <.link navigate={@edit_path} class="text-blue-600 hover:underline">Edit</.link>
        <.link navigate={@show_path} class="text-gray-700 hover:underline">Show</.link>
        <.form :let={_f} for={%{}} action={@delete_path} method="delete" class="inline">
          <button type="submit"
                  data-confirm="Are you sure you want to delete this task?"
                  class="text-red-600 hover:underline bg-transparent border-0 cursor-pointer">
            Delete
          </button>
        </.form>
      </div>
    </div>
    """
  end
end

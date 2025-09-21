defmodule TasksApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TasksAppWeb.Telemetry,
      TasksApp.Repo,
      {DNSCluster, query: Application.get_env(:tasks_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TasksApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TasksApp.Finch},
      # Start a worker by calling: TasksApp.Worker.start_link(arg)
      # {TasksApp.Worker, arg},
      # Start to serve requests, typically the last entry
      TasksAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TasksApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TasksAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

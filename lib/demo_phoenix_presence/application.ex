defmodule DemoPhoenixPresence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DemoPhoenixPresenceWeb.Telemetry,
      DemoPhoenixPresence.Repo,
      {DNSCluster, query: Application.get_env(:demo_phoenix_presence, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DemoPhoenixPresence.PubSub},
      # Start the Presence system
      DemoPhoenixPresenceWeb.Presence,
      # Start a worker by calling: DemoPhoenixPresence.Worker.start_link(arg)
      # {DemoPhoenixPresence.Worker, arg},
      # Start to serve requests, typically the last entry
      DemoPhoenixPresenceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DemoPhoenixPresence.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DemoPhoenixPresenceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

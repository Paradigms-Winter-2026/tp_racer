defmodule TpRacer.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TpRacerWeb.Telemetry,
      TpRacer.Repo,
      {DNSCluster, query: Application.get_env(:tp_racer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TpRacer.PubSub},
      # Start a worker by calling: TpRacer.Worker.start_link(arg)
      # {TpRacer.Worker, arg},
      # Start to serve requests, typically the last entry
      TpRacerWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TpRacer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TpRacerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

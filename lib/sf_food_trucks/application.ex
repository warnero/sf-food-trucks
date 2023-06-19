defmodule SfFoodTrucks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SfFoodTrucksWeb.Telemetry,
      # Start the Ecto repository
      SfFoodTrucks.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SfFoodTrucks.PubSub},
      # Start Finch
      {Finch, name: SfFoodTrucks.Finch},
      # Start the Endpoint (http/https)
      SfFoodTrucksWeb.Endpoint
      # Start a worker by calling: SfFoodTrucks.Worker.start_link(arg)
      # {SfFoodTrucks.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SfFoodTrucks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SfFoodTrucksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

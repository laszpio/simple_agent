defmodule SimpleAgent.Application do
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: SimpleAgent.Endpoint,
        options: [port: port()]
      )
    ]

    opts = [strategy: :one_for_one, name: SimpleAgent.Supervisor]

    Logger.info("Accepting connections on port #{port()}")

    Supervisor.start_link(children, opts)
  end

  def port, do: Application.get_env(:simple_agent, :port, 5000)
end

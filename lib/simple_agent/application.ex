defmodule SimpleAgent.Application do
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: SimpleAgent.HelloWorldPlug, options: [port: 5000]}
    ]
    opts = [strategy: :one_for_one, name: SimpleAgent.Supervisor]

    Logger.info("Accepting connections on port 5000")

    Supervisor.start_link(children, opts)
  end
end

defmodule SimpleAgent do
  require Logger

  def register() do
    result = %SimpleAgent.Register{
      name: "SimpleAgent",
      display_name: "Simple Elixir Agent",
      description: "Simple Elixir Agent",
      default_options: %{}
    }

    {:ok, result}
  end

  def check(request) do
    result = %SimpleAgent.Check{}

    Logger.info(request)

    {:ok, result}
  end

  def receive(_request) do
    result = %SimpleAgent.Receive{}
    {:ok, result}
  end
end

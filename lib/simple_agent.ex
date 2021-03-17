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
    message = get_in(request, [:params, :memory]) || []

    result = %SimpleAgent.Check{}
             |> Map.put(:logs, ['Check done'])
             |> Map.put(:errors, ['Sample error'])
             |> Map.update!(:messages, &(&1 ++ message))

    {:ok, result}
  end

  def receive(_request) do
    result = %SimpleAgent.Receive{}
    {:ok, result}
  end
end

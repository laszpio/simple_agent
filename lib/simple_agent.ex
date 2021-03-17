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

    result = %SimpleAgent.Response{}
             |> Map.put(:logs, ['Check done'])
             |> Map.put(:errors, ['Sample error'])
             |> Map.update!(:messages, &(&1 ++ message))

    {:ok, result}
  end

  def receive(request) do
    result = %SimpleAgent.Response{}
              |> Map.put(:logs, ["New message received"])
              |> Map.put(:memory, get_in(request, [:params, :memory] || %{}))

    {:ok, result}
  end
end

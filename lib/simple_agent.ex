defmodule SimpleAgent do
  require Logger

  alias SimpleAgent.Response
  alias SimpleAgent.Register

  import SimpleAgent.Response

  def register() do
    result = %Register{
      name: "SimpleAgent",
      display_name: "Simple Elixir Agent",
      description: "Simple Elixir Agent",
      default_options: %{}
    }

    {:ok, result}
  end

  def check(request) do
    message = get_in(request, [:params, :memory]) || []

    %Response{}
    |> Map.put(:logs, ['Check done'])
    |> Map.put(:errors, ['Sample error'])
    |> Map.update!(:messages, &(&1 ++ message))
    |> validate
  end

  def receive(request) do
    %Response{}
    |> Map.put(:logs, ["New message received"])
    |> Map.put(:memory, get_in(request, [:params, :memory] || %{}))
    |> validate
  end
end

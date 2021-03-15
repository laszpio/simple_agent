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

  def check(_params) do
    {:ok, empty_result()}
  end

  def receive(_params) do
    {:ok, empty_result()}
  end

  defp empty_result do
    %SimpleAgent.Result{}
  end
end

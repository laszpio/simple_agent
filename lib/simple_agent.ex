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
    {:ok, empty_check()}
  end

  def receive(_params) do
    {:ok, empty_receive()}
  end

  defp empty_check, do: %SimpleAgent.Check{}

  defp empty_receive, do: %SimpleAgent.Receive{}
end

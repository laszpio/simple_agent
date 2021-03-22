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
    %Response{}
    |> add(:logs, "Check done")
    |> add(:errors, "Sample error")
    |> validate
  end

  def receive(request) do
    %Response{}
    |> add(:logs, "Message received")
    |> Map.put(:memory, %{key: "value"})
    |> validate
  end
end

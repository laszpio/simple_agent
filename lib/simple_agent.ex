defmodule SimpleAgent do
  @behaviour SimpleAgent.Agent

  alias SimpleAgent.Agent
  alias SimpleAgent.Request
  alias SimpleAgent.Response
  alias SimpleAgent.Register

  import SimpleAgent.Response

  @impl Agent
  def handle_register() do
    result = %Register{
      name: "SimpleAgent",
      display_name: "Simple Elixir Agent",
      description: "Simple Elixir Agent",
      default_options: %{}
    }

    {:ok, result}
  end

  @impl Agent
  def handle_check(%Request{} = _request) do
    %Response{}
    |> add(:logs, "Check done")
    |> add(:errors, "Sample error")
    |> validate
  end

  @impl Agent
  def handle_receive(%Request{} = _request) do
    %Response{}
    |> add(:logs, "Message received")
    |> add(:memory, %{key: "value"})
    |> validate
  end
end

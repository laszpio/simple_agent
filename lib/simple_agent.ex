defmodule SimpleAgent do
  alias SimpleAgent.Request
  alias SimpleAgent.Response
  alias SimpleAgent.Register

  import SimpleAgent.Response

  def handle_register() do
    result = %Register{
      name: "SimpleAgent",
      display_name: "Simple Elixir Agent",
      description: "Simple Elixir Agent",
      default_options: %{}
    }

    {:ok, result}
  end

  def handle_check(%Request{} = _request) do
    %Response{}
    |> add(:logs, "Check done")
    |> add(:errors, "Sample error")
    |> validate
  end

  def handle_receive(%Request{} = _request) do
    %Response{}
    |> add(:logs, "Message received")
    |> add(:memory, %{key: "value"})
    |> validate
  end
end

defmodule SimpleAgent do
  require Logger

  @register_response %{
    result: %{
      name: "MyAgent",
      display_name: "My Agent",
      description: "My First Agent",
      default_options: %{option: "value"}
    }
  }

  @receive_response %{
    result: %{
      errors: [
        "Something failed",
        "Something more failed"
      ],
      logs: [
        "Something happened",
        "Something else happened"
      ],
      memory: %{
        key: "new value"
      },
      messages: [
        %{a: 5},
        %{a: 6}
      ]
    }
  }

  @check_response @receive_response

  def register() do
    {:ok, @register_response}
  end

  def check(_params) do
    {:ok, @check_response}
  end

  def receive(_params) do
    {:ok, @receive_response}
  end
end

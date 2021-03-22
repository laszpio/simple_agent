defmodule SimpleAgentRequestTest do
  use ExUnit.Case
  doctest SimpleAgent.Request

  import SimpleAgent.Request

  describe "check request" do
    @params %{
      message: nil,
      options: %{
        option: "value"
      },
      memory: %{
        key: "value"
      },
      credentials: [
        %{ name: "admin_email", value: "admin@example.org" }
      ]
    }
  end
end

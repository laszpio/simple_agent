defmodule SimpleAgentRequestTest do
  use ExUnit.Case
  doctest SimpleAgent.Request

  import SimpleAgent.Request
  alias SimpleAgent.Request

  describe "check request" do
    @check_params %{
      message: nil,
      options: %{
        option: "value"
      },
      memory: %{
        key: "value"
      },
      credentials: [
        %{name: "admin_email", value: "admin@example.org"}
      ]
    }

    test "from_params/2 returns Request with options" do
      {:ok, %Request{options: options}} = from_params(:check, @check_params)
      assert options == %{option: "value"}
    end

    test "from_params/2 returns Request with memory" do
      {:ok, %Request{memory: memory}} = from_params(:check, @check_params)
      assert memory == %{key: "value"}
    end

    test "from_params/2 returns Request with credentials" do
      {:ok, %Request{credentials: credentials}} = from_params(:check, @check_params)

      assert credentials == [
               %{name: "admin_email", value: "admin@example.org"}
             ]
    end
  end
end

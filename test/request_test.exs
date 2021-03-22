defmodule SimpleAgentRequestTest do
  use ExUnit.Case
  doctest SimpleAgent.Request

  import SimpleAgent.Request
  alias SimpleAgent.Request

  describe "check request" do
    @check_request %{
      method: "check",
      params: %{
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
    }

    test "from_params/2 returns Request with options" do
      {:ok, %Request{options: options}} = from_params(@check_request)
      assert options == %{option: "value"}
    end

    test "from_params/2 returns Request with memory" do
      {:ok, %Request{memory: memory}} = from_params(@check_request)
      assert memory == %{key: "value"}
    end

    test "from_params/2 returns Request with credentials" do
      {:ok, %Request{credentials: credentials}} = from_params(@check_request)

      assert credentials == [
               %{name: "admin_email", value: "admin@example.org"}
             ]
    end
  end

  describe "receive request" do
    @receive_request %{
      method: "receive",
      params: %{
        message: %{
          payload: %{a: 1, b: 2}
        },
        options: %{
          option: "value",
          email_credential: "admin_email"
        },
        memory: %{
          key: "value"
        },
        credentials: [
          %{name: "admin_email", value: "admin@example.org"}
        ]
      }
    }

    test "from_params/2 returns Request with options" do
      {:ok, %Request{options: options}} = from_params(@receive_request)

      assert options == %{
               email_credential: "admin_email",
               option: "value"
             }
    end

    test "from_params/2 returns Request with memory" do
      {:ok, %Request{memory: memory}} = from_params(@receive_request)
      assert memory == %{key: "value"}
    end

    test "from_params/2 returns Request with credentials" do
      {:ok, %Request{credentials: credentials}} = from_params(@receive_request)

      assert credentials == [
               %{name: "admin_email", value: "admin@example.org"}
             ]
    end

    test "from_params/2 returns Request with message" do
      {:ok, %Request{message: message}} = from_params(@receive_request)
      assert message == %{a: 1, b: 2}
    end
  end
end

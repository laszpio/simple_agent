defmodule SimpleAgentResponseTest do
  use ExUnit.Case
  doctest SimpleAgent.Request

  import SimpleAgent.Response

  @response %SimpleAgent.Response{}

  describe "response structure defaults" do
    test "errors is an empty list" do
      assert @response.errors == []
    end

    test "logs is an empty list" do
      assert @response.logs == []
    end

    test "messages is an empty list" do
      assert @response.messages == []
    end

    test "memory is an empty map" do
      assert @response.memory == %{}
    end
  end

  describe "add/3" do
    test "appends error to response" do
      result = add(@response, :errors, "Error 1")
      assert result.errors == ["Error 1"]

      result = add(result, :errors, "Error 2")
      assert result.errors == ["Error 1", "Error 2"]
    end

    test "appends log entry to response" do
      result = add(@response, :logs, "Log 1")
      assert result.logs == ["Log 1"]

      result = add(result, :logs, "Log 2")
      assert result.logs == ["Log 1", "Log 2"]
    end

    test "appends message to resposne" do
      result = add(@response, :messages, "Message 1")
      assert result.messages == ["Message 1"]

      result = add(result, :messages, "Message 2")
      assert result.messages == ["Message 1", "Message 2"]
    end

    test "merges memory to response" do
      result = @response

      result = add(result, :memory, %{first_key: "some value"})
      assert result.memory == %{first_key: "some value"}

      result = add(result, :memory, %{first_key: "value"})
      assert result.memory == %{first_key: "value"}

      result = add(result, :memory, %{other_key: "other value"})
      assert result.memory == %{first_key: "value", other_key: "other value"}
    end

    test "raises exception when adding not existant key to response" do
      assert_raise KeyError, ~r/key :unknown not found in: %SimpleAgent.Response/, fn ->
        add(@response, :unknown, "value")
      end
    end
  end
end

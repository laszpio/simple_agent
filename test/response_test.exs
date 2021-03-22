defmodule SimpleAgentResponseTest do
  use ExUnit.Case
  doctest SimpleAgent.Response

  import SimpleAgent.Response
  alias SimpleAgent.Response

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

    test "raises error when adding non-map memory to response" do
      assert_raise ArgumentError, "memory must be a map", fn ->
        add(@response, :memory, nil)
      end

      assert_raise ArgumentError, "memory must be a map", fn ->
        add(@response, :memory, 'str')
      end

      assert_raise ArgumentError, "memory must be a map", fn ->
        add(@response, :memory, 1)
      end

      assert_raise ArgumentError, "memory must be a map", fn ->
        add(@response, :memory, [])
      end
    end

    test "raises error when adding non-binary to list attributes" do
      for list_attr <- [:errors, :logs, :messages],
          bad_value <- [nil, 1, '', [], %{}] do
        assert_raise ArgumentError, "#{list_attr} must be a binary", fn ->
          add(@response, list_attr, bad_value)
        end
      end
    end

    test "raises error when adding not-existant key to response" do
      assert_raise KeyError, ~r/key :unknown not found in: %SimpleAgent.Response/, fn ->
        add(@response, :unknown, "value")
      end
    end
  end

  describe "validate/1" do
    test "validates empty response" do
      assert {:ok, @response} == validate(@response)
    end

    test "returns {:ok, response} when attributes valid" do
      response = %Response{
        errors: ["Error 1", "Error 2"],
        logs: ["Log 1", "Log 2"],
        messages: ["Message 1", "Message 2"],
        memory: %{key: "value"}
      }

      assert {:ok, response} == validate(response)
    end

    test "returns :error when reponse with invalid errors atributes" do
      response = %Response{errors: nil}
      assert :error == validate(response)

      response = %Response{errors: ["Error 1", nil]}
      assert :error == validate(response)
    end

    test "returns :error when reponse with invalid logs" do
      response = %Response{logs: nil}
      assert :error == validate(response)

      response = %Response{errors: ["Log 1", nil]}
      assert :error == validate(response)
    end

    test "returns :messages when reponse with invalid messages" do
      response = %Response{messages: nil}
      assert :error == validate(response)

      response = %Response{errors: ["Message 1", nil]}
      assert :error == validate(response)
    end

    test "returns :memory when reponse with invalid memory" do
      response = %Response{messages: nil}
      assert :error == validate(response)
    end
  end
end

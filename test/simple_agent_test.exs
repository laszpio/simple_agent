defmodule SimpleAgentTest do
  use ExUnit.Case
  doctest SimpleAgent

  use Plug.Test

  @opts SimpleAgent.Endpoint.init([])

  describe "register" do
    test "returns 200" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "register"}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      assert conn.status == 200
    end

    test "returns result with register structure" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "register"}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      %{result: result} = Jason.decode!(conn.resp_body, keys: :atoms!)

      assert result == %{
               name: "SimpleAgent",
               display_name: "Simple Elixir Agent",
               description: "Simple Elixir Agent",
               default_options: %{}
             }
    end
  end

  describe "check" do
    @check_params %{
      method: "check",
      params: %{
        message: nil,
        options: %{option: "value"},
        memory: %{key: "value"},
        credentials: [
          %{name: "admin_email", value: "admin@example.com"}
        ]
      }
    }

    test "returns 200" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "check", params: @check_params}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      assert conn.status == 200
    end

    test "returns result with check structure" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "check", params: %{}}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      %{result: result} = Jason.decode!(conn.resp_body, keys: :atoms!)

      assert result == %{
               errors: ["Sample error"],
               logs: ["Check done"],
               messages: [],
               memory: %{}
             }
    end
  end

  describe "receive" do
    @request_params %{
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
          %{name: "admin_email", value: "admin@example.com"}
        ]
      }
    }

    test "returns 200" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "receive", params: @request_params}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      assert conn.status == 200
    end

    test "returns result with receive structure" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "receive", params: @request_params}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      %{result: result} = Jason.decode!(conn.resp_body, keys: :atoms!)

      assert result == %{
               errors: [],
               logs: ["Message received"],
               messages: [],
               memory: %{key: "value"}
             }
    end
  end

  test "returns 422 with empty request" do
    conn =
      conn(:post, "/")
      |> put_req_header("content-type", "application/json")
      |> SimpleAgent.Endpoint.call(@opts)

    assert conn.status == 422
    assert conn.resp_body == Jason.encode!(%{result: "Unknown method"})
  end
end

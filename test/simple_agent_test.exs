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
    test "returns 200" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "check", params: %{}}))
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
      assert result == %{errors: [], logs: [], messages: []}
    end
  end

  describe "receive" do
    test "returns 200" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "receive", params: %{}}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      assert conn.status == 200
    end

    test "returns result with receive structure" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "receive", params: %{}}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      %{result: result} = Jason.decode!(conn.resp_body, keys: :atoms!)
      assert result == %{errors: [], logs: [], messages: [], memory: %{}}
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

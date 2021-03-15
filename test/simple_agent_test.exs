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
  end

  describe "check" do
    test "returns 200" do
      conn =
        conn(:post, "/", Jason.encode!(%{method: "check", params: %{}}))
        |> put_req_header("content-type", "application/json")
        |> SimpleAgent.Endpoint.call(@opts)

      assert conn.status == 200
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
  end

  test "returns 422 with empty request" do
    conn =
      conn(:post, "/")
      |> put_req_header("content-type", "application/json")
      |> SimpleAgent.Endpoint.call(@opts)

    assert conn.status == 422
    assert conn.resp_body == Jason.encode!(%{response: "Unknown method"})
  end
end

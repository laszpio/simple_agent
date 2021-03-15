defmodule SimpleAgent.Endpoint do
  @moduledoc false

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: {Jason, :decode!, [[keys: :atoms]]})
  plug(:dispatch)

  require Logger

  post "/" do
    Logger.info(conn.body_params)

    with {status, result} <- process_request(conn.body_params),
         {:ok, body} <- Jason.encode(result) do
      send_resp(conn, status, body)
    end
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end

  defp process_request(%{method: "register"}) do
    with {:ok, result} <- SimpleAgent.register() do
      {200, result}
    end
  end

  defp process_request(%{method: "check", params: params}) do
    with {:ok, result} <- SimpleAgent.check(params) do
      {200, result}
    end
  end

  defp process_request(%{method: "receive", params: params}) do
    with {:ok, result} <- SimpleAgent.receive(params) do
      {200, result}
    end
  end

  defp process_request(_) do
    {422, %{response: "Unknown method"}}
  end
end

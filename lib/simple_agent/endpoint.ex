defmodule SimpleAgent.Endpoint do
  @moduledoc false

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: {Jason, :decode!, [[keys: :atoms]]})
  plug(:dispatch)

  post "/" do
    with {status, result} <- process_request(conn.body_params),
         {:ok, body} <- Jason.encode(%{result: result}) do
      send_resp(conn, status, body)
    end
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end

  defp process_request(%{method: "register"}) do
    with {:ok, result} <- SimpleAgent.handle_register() do
      {200, result}
    end
  end

  defp process_request(%{method: "check"} = params) do
    with {:ok, params} <- SimpleAgent.Request.from_params(params),
         {:ok, result} <- SimpleAgent.handle_check(params) do
      {200, result}
    end
  end

  defp process_request(%{method: "receive", params: params}) do
    with {:ok, params} <- SimpleAgent.Request.from_params(params),
         {:ok, result} <- SimpleAgent.handle_receive(params) do
      {200, result}
    end
  end

  defp process_request(_) do
    {422, "Unknown method"}
  end
end

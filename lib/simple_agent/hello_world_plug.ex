defmodule SimpleAgent.HelloWorldPlug do
  import Plug.Conn
  require Logger

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello World!\n")

    Logger.info("Hello World!")
  end
end

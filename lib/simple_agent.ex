defmodule SimpleAgent do
  require Logger

  def register() do
    Logger.info("Register")
    {:ok, Jason.encode!(%{response: "Registered!"})}
  end

  def check(_params) do
    Logger.info("Check")
    {:ok, Jason.encode!(%{response: "Checked!"})}
  end

  def receive(_params) do
    Logger.info("Receive")
    {:ok, Jason.encode!(%{response: "Received!"})}
  end
end

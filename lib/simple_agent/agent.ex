defmodule SimpleAgent.Agent do
  @type request() :: SimpleAgent.Request.t()
  @type register() :: SimpleAgent.Register.t()
  @type response() :: SimpleAgent.Response.t()

  @doc """
  Handles register request
  """
  @callback handle_register() :: {:ok, register()}

  @doc """
  Handles check request
  """
  @callback handle_check(request()) :: {:ok, response()} | :error

  @doc """
  Handles receive request
  """
  @callback handle_receive(request()) :: {:ok, response()} | :error
end

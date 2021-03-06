defmodule SimpleAgent.Request do
  @type t :: %__MODULE__{
          message: nil | list,
          options: map,
          memory: map,
          credentials: list
        }

  defstruct message: nil,
            options: %{},
            memory: %{},
            credentials: []

  def from_params(%{
        method: "check",
        params: %{options: o, memory: m, credentials: c}
      }) do
    {:ok, %__MODULE__{options: o, memory: m, credentials: c}}
  end

  def from_params(%{
        method: "receive",
        params: %{message: %{payload: p}, options: o, memory: m, credentials: c}
      }) do
    {:ok, %__MODULE__{message: p, options: o, memory: m, credentials: c}}
  end

  def from_params(_, _), do: :error
end

defmodule SimpleAgent.Request do
  defstruct message: nil,
            options: %{},
            memory: %{},
            credentials: []

  def from_params(:check, %{options: o, memory: m, credentials: c}) do
    %__MODULE__{options: o, memory: m, credentials: c}
  end

  def from_params(:receive, %{message: %{payload: p}, options: o, memory: m, credentials: c}) do
    %__MODULE__{message: p, options: o, memory: m, credentials: c}
  end

  def from_params(_, _), do: :error
end

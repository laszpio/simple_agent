defmodule SimpleAgent.Result do
  @derive Jason.Encoder
  defstruct errors: [], logs: [], messages: [], memory: %{}
end

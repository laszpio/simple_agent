defmodule SimpleAgent.Response do
  @derive Jason.Encoder
  defstruct errors: [],
            logs: [],
            messages: [],
            memory: %{}

  def validate(%__MODULE__{} = response), do: {:ok, response}

  def validate(_response), do: :error
end

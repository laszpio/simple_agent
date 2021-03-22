defmodule SimpleAgent.Response do
  @derive Jason.Encoder
  defstruct errors: [],
            logs: [],
            messages: [],
            memory: %{}

  def add(%__MODULE__{} = response, k, v) when is_binary(v) do
    Map.update!(response, k, &(&1 ++ [v]))
  end

  def validate(%__MODULE__{} = response), do: {:ok, response}

  def validate(_response), do: :error
end

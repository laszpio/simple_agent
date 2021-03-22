defmodule SimpleAgent.Response do
  @derive Jason.Encoder
  defstruct errors: [],
            logs: [],
            messages: [],
            memory: %{}

  def add(%__MODULE__{} = response, :memory, v) when is_map(v) do
    Map.update!(response, :memory, &Map.merge(&1, v))
  end

  def add(%__MODULE__{} = response, k, v) when is_binary(v) do
    Map.update!(response, k, &(&1 ++ [v]))
  end

  def add(_, :memory, _), do: raise(ArgumentError, "memory must be a map")

  def add(_, k, _), do: raise(ArgumentError, "#{k} must be a binary")

  def validate(%__MODULE__{} = response), do: {:ok, response}

  def validate(_response), do: :error
end

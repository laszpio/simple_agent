defmodule SimpleAgent.Response do
  @derive Jason.Encoder
  defstruct errors: [],
            logs: [],
            messages: [],
            memory: %{}
end

defmodule SimpleAgent.Receive do
  @derive Jason.Encoder
  defstruct errors: [],
            logs: [],
            messages: [],
            memory: %{}
end

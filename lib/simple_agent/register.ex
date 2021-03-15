defmodule SimpleAgent.Register do
  @derive Jason.Encoder
  defstruct [:name, :display_name, :description, default_options: %{}]
end

defmodule SimpleAgent.Register do
  @derive Jason.Encoder

  @type t :: %__MODULE__{
          name: binary,
          display_name: binary,
          description: binary,
          default_options: map
        }

  defstruct [
    :name,
    :display_name,
    :description,
    default_options: %{}
  ]
end

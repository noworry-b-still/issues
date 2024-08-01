defmodule StashSequence.Application do
  @moduledoc """
  Supervisor application to take care of server and stash
  """
  use Application

  def start(_type, _args) do
    children = [
      {StashSequence.Stash}
    ]
  end
end

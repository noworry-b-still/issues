defmodule StashSequence.Application do
  @moduledoc """
  Supervisor application to take care of server and stash
  """
  use Application

  def start(_type, _args) do
    children = [
      {StashSequence.Stash, 123},
      {StashSequence.Server, nil}
    ]

    opts = [strategy: :rest_for_one, name: StashSequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

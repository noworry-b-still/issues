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


# iex(1)> StashSequence.Application.start(:normal, [])
# {:ok, #PID<0.237.0>}
# iex(2)> StashSequence.Server.next_number\
# ...(2)> StashSequence.Server.next_number\
# ...(2)> StashSequence.Server.next_number
# ** (UndefinedFunctionError) function StashSequence.Server.next_number/1 is undefined or private. Did you mean:

#       * next_number/0

#     (issues 0.1.0) StashSequence.Server.next_number(123)
#     iex:3: (file)
# iex(2)> StashSequence.Server.next_number
# 124
# iex(3)> StashSequence.Server.next_number
# 125
# iex(4)> StashSequence.Server.increment_number 2
# :ok
# iex(5)> StashSequence.Server.increment_number "2"
# :ok
# iex(6)>
# 11:05:21.698 [error] GenServer StashSequence.Server terminating
# ** (ArithmeticError) bad argument in arithmetic expression
#     :erlang.+(128, "2")
#     (issues 0.1.0) lib/stash_sequence/server.ex:31: StashSequence.Server.handle_cast/2
#     (stdlib 4.3.1.3) gen_server.erl:1123: :gen_server.try_dispatch/4
#     (stdlib 4.3.1.3) gen_server.erl:1200: :gen_server.handle_msg/6
#     (stdlib 4.3.1.3) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
# Last message: {:"$gen_cast", {:increment_number, "2"}}
# State: 128

# nil
# iex(7)> StashSequence.Server.increment_number 2
# :ok
# iex(8)> StashSequence.Server.next_number
# 130

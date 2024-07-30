defmodule GenServer.TextGenServer do
  @moduledoc """
  A GenServer that prints the messages it receives to the command line and can forward messages
  to other processes.
  """

  use GenServer

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def forward_message(pid, message) do
    GenServer.cast(__MODULE__, {:forward, pid, message})
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_cast({:forward, pid, message}, state) do
    IO.puts("Forwarding message: #{inspect(message)} to #{inspect(pid)}")
    send(pid, message)
    {:noreply, state}
  end

  def handle_info(message, state) do
    IO.puts("#{inspect(message)}")
    {:noreply, state}
  end
end

# TODO:
# 1. refactor the client API and server callbacks into separate modules


# Driver Code:

IO.puts "\n\n Spinning the GenServer"

{:ok, pid} = GenServer.TextGenServer.start_link([])


IO.puts "\n GenServer running as #{inspect(pid)} "

IO.puts "\n\n Spawning a new process"
pid_of_new_process = spawn(fn ->
  receive do
    msg ->
      IO.puts "Recieved in new process: #{inspect msg}"
  end
end)
IO.puts "\n\n #{inspect pid_of_new_process} is running."


IO.puts "\n\n Sending a message to GenServer"

GenServer.TextGenServer.forward_message(pid_of_new_process, "Hi Dinesh, I just received your message")

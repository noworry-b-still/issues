defmodule GenServer.CheckInSyncGenServer do
  @moduledoc """
  A GenServer that sends a message to a specific process if it hasn't received a message in ~5 seconds,
  """

  use GenServer

  # client api
  def start_link(target_process) do
    GenServer.start_link(__MODULE__, target_process, name: __MODULE__)
  end

  def send_message(message) do
    GenServer.cast(__MODULE__, {:send_message, message})
  end

  # server callbacks

  def init(target_process) do
    timer = Process.send_after(self(), :timeout, 5000)

    state = %{
      target_process: target_process,
      timer: timer
    }

    {:ok, state}
  end

  def handle_cast({:send_message, message}, state) do
    if state.timer do
      Process.cancel_timer(state.timer)
    end

    send(state.target_process, message)
    timer = Process.send_after(self(), :timeout, 5000)
    {:noreply, %{state | timer: timer}}
  end

  def handle_info(:timeout, state) do
    send(state.target_process, :timeout_message)
    timer = Process.send_after(self(), :timeout, 5000)
    {:noreply, %{state | timer: timer}}
  end
end

# driver code

# pid_of_target_process =
#   spawn(fn ->
#     receive do
#       msg ->
#         IO.puts("Recieved in new process: #{inspect(msg)}")
#     end
#   end)

# {:ok, _pid} = GenServer.CheckInSyncGenServer.start_link(pid_of_target_process)

#  donot send the message to genserver, it then sends out the timout message to target process after 5seconds.
# GenServer.CheckInSyncGenServer.send_message(:some_message)

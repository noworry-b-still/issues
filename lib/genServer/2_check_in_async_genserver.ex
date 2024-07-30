defmodule GenServer.CheckInAsyncGenServer do
  @moduledoc """
  A GenServer that sends a message to a specific process every ~5 seconds
  even if it is handling a lot of messages.
  """
  use GenServer

  # Client API

  def start_link(target_process) do
    GenServer.start_link(__MODULE__, target_process, name: __MODULE__)
  end

  def send_message(message) do
    GenServer.cast(__MODULE__, {:send_message, message})
  end

  # Server Callbacks

  @impl true
  def init(target_process) do
    # Start with an initial timer to send a message every ~5 seconds
    schedule_periodic_send()

    state = %{
      target_process: target_process,
      last_sent_at: :erlang.system_time(:millisecond)
    }

    {:ok, state}
  end

  @impl true
  def handle_cast({:send_message, message}, state) do
    IO.puts("Received message: #{inspect(message)}")
    {:noreply, state}
  end

  @impl true
  def handle_info(:send_periodic_message, state) do
    send(state.target_process, :periodic_message)

    now = :erlang.system_time(:millisecond)
    elapsed_time = now - state.last_sent_at
    IO.puts("Time since last message: #{elapsed_time} milliseconds")

    new_state = %{state | last_sent_at: now}

    schedule_periodic_send()

    {:noreply, new_state}
  end

  defp schedule_periodic_send do
    Process.send_after(self(), :send_periodic_message, 5000)
  end
end


# pid_of_target_process =
#   spawn(fn ->
#     receive do
#       msg ->
#         IO.puts("Recieved in new process: #{inspect(msg)}")
#     end
#   end)

# {:ok, _pid } = GenServer.CheckInAsyncGenServer.start_link(pid_of_target_process)

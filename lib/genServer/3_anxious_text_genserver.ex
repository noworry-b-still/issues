defmodule GenServer.AnxiousTextGenServer do
  @moduledoc """
  A GenServer that replies to calls, and if it haven't gotten a message after some fixed period (say ~5 seconds)
  checks if the last process that sent it a message is still alive, and if it is, send it a message (you should do this with a process that is receiving messages so you can check that it got sent).
  """

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def call_message(message) do
    GenServer.call(__MODULE__, {:call_message, message})
  end

  # callbacks

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:call_message, message}, from, _state) do
    IO.puts("#{inspect(message)} is received - Processing it...")

    new_state = %{
      last_sender: from,
      timeout_ref: Process.send_after(self(), {:check_timeout, from}, 5000)
    }

    {:reply, :ok, new_state}
  end

  @impl true
  def handle_info({:check_timeout, sender}, state) do
    {sender_pid, _sender_ref} = sender

    if Process.alive?(sender_pid) do
      send(sender_pid, :timeout_notification)
    end

    new_state = Map.delete(state, :timeout_ref)
    {:noreply, new_state}
  end
end

# {:ok, pid} = GenServer.AnxiousTextGenServer.start_link()

# pid_of_target_process =
#   spawn(fn ->
#     GenServer.AnxiousTextGenServer.call_message("Hi Anxious, Love you!!")

#     receive do
#       :timeout_notification ->
#         IO.puts("#{:timeout_notification} : dont worry, talk to you later!!")
#     end
#   end)

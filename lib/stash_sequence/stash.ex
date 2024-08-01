defmodule StashSequence.Stash do
  @moduledoc """
  Server that stores a number and provide related routines.
  """

  use GenServer

  @me __MODULE__

  # API
  def start_link(initial_number) do
    GenServer.start_link(__MODULE__, initial_number, name: @me)
  end

  @doc """
  Make a call to get the number(state)
  """
  def get() do
    GenServer.call(@me, {:get})
  end

  @doc """
  Make a cast to update the number(state)
  """
  def update(new_number) do
    GenServer.cast(@me, {:update, new_number})
  end

  # callbacks

  def init(initial_number), do: {:ok, initial_number}

  def handle_call({:get}, _from, current_number_in_state) do
    {:reply, current_number_in_state, current_number_in_state}
  end

  def handle_cast({:update, new_number}, _current_number) do
    {:noreply, new_number}
  end
end

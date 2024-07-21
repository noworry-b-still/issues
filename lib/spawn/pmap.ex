defmodule Parallel do
  def pmap(collection, func) do
    calling_process_pid = self()

    collection
    |> Enum.map(fn el ->
      spawn(fn ->
        send(calling_process_pid, {self(), func.(el)})
      end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} ->
          result
      end
    end)
  end
end


# Regular map returns the list that results from appling a function to each element of a collection.
# The parallel version does the same but it applies the function to each element in a separate process.

# THIS is typical -- be aware.

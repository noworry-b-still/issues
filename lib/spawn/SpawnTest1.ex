defmodule SpawnTest1 do

  def greet() do
    receive do
      {sender, message} ->
        send sender, {:ok, "Hi #{message}"}
    end
  end
end


pid = spawn(SpawnTest1, :greet, [])
send pid, {self(), "Dinesh"}

receive do
  {:ok, message} ->
    # code
    IO.puts "This is what i recieved #{message}"
end

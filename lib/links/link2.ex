defmodule Link2 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    spawn_link(Link2, :sad_function, [])

    receive do
      msg ->
        IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
    after
      1000 ->
        IO.puts("Nothing happened as far as I am concerned")
    end
  end
end

# Link2.run()

# We can link two processes, which lets each receive information when the other exits.
# A call to the spawn_link spawns a process and links it to the caller in one operation.

# The runtime reports the abnormal termination.
# So, our child process died, and it killed the entire application.
# That’s the default behavior of linked processes. When one exits abnormally, it kills the other.

# What if we want to handle the death of another process? Well, we probably don’t want to do this.
# Elixir uses the OTP framework for constructing process trees, and OTP includes the concept of process supervision.
#  An incredible amount of effort has been spent getting this right, so we recommend using it most of the time.

# However, we can tell Elixir to convert the exit signals from a linked process into a message we can handle. We do this by trapping the exit.

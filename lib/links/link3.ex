defmodule Link3 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link3, :sad_function, [])

    receive do
      msg ->
        IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
    after
      1000 ->
        IO.puts("Nothing happened as far as I am concerned")
    end
  end
end

Link3.run()

# Linking joins the calling process and another process. Each receives notifications about the other.
# By contrast, monitoring lets a process spawn another and be notified of its termination, but without the reverse notification.
# It’s one way only.

defmodule Fib do
  def of(0), do: 0
  def of(1), do: 1
  def of(n) when is_integer(n), do: Fib.of(n - 1) + Fib.of(n - 2)
end

IO.puts("Start the task...")
worker = Task.async(fn -> Fib.of(20) end)
worker_2 = Task.async(Fib, :of, [20])

IO.puts(inspect(worker))
IO.puts(is_map(worker))
IO.puts("Do something else...")

IO.puts("Wait for the task...")
result = Task.await(worker)
result_2 = Task.await(worker_2)

IO.puts("The result is #{result}")
IO.puts("The result is #{result_2}")

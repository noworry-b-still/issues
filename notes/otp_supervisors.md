Up till now, we’ve seen how the supervision strategy tells the supervisor to deal with the death of a child process.

There’s a second level of configuration that applies to individual workers. The most commonly used of these is the :restart option.

Previously, we said that a supervisor strategy (such as :one_for_all) is invoked when a worker dies. That’s not strictly true. Instead, the strategy is invoked when a worker needs restarting. And the conditions when a worker should be restarted are dictated by its restart: option:

If :permanent, this worker should always be running. it’s permanent. This means that the supervision strategy will be applied whenever this worker terminates, for whatever reason.

If :temporary, this worker should never be restarted, so the supervision strategy is never applied if this worker dies.

If :transient, it’s expected that this worker will at some point terminate normally, and this termination shouldn’t result in a restart. However, should this worker die abnormally, then it should be restarted by running the supervision strategy. The simplest way to specify the restart option for a worker is in the worker module. And we add it to the use GenServer (or use Supervisor) statement:

defmodule Convolver do
use GenServer, restart: :transient
#...

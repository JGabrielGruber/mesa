defmodule Mesa.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {DynamicSupervisor, name: Mesa.BucketSupervisor, strategy: :one_for_one},
      {Mesa.Registry, name: Mesa.Registry},
      {Task.Supervisor, name: Mesa.RouterTasks}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end

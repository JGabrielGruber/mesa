defmodule MesaServer.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = String.to_integer(System.get_env("PORT") || "4040")

    children = [
      {Task.Supervisor, name: MesaServer.TaskSupervisor},
      Supervisor.child_spec({Task, fn -> MesaServer.accept(port) end}, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: MesaServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

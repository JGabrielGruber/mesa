defmodule Mesa do
  use Application

  @impl true
  def start(_type, _args) do
    # Althrough we don't use the supervisor name below directly,
    # it can be useful when debugging or introspecting the system.
    Mesa.Supervisor.start_link(name: Mesa.Supervisor)
  end
end

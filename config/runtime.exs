import Config

config :mesa, :routing_table, [{?a..?z, node()}]

if config_env() == :prod do
  config :mesa, :routing_table, [
    {?a..?m, "foo@phury"},
    {?n..?z, "bar@phury"}
  ]
end

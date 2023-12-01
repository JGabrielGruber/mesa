defmodule Mesa.RouterTest do
  use ExUnit.Case

  setup_all do
    current = Application.get_env(:mesa, :routing_table)

    Application.put_env(:mesa, :routing_table, [
      {?a..?m, :"foo@phury"},
      {?n..?z, :"bar@phury"}
    ])

    on_exit fn -> Application.put_env(:mesa, :routing_table, current) end
  end

  @tag :distributed
  test "route requests across nodes" do
    assert Mesa.Router.route("hello", Kernel, :node, []) ==
      :"foo@phury"
    assert Mesa.Router.route("world", Kernel, :node, []) ==
      :"bar@phury"
  end

  test "raises on unknown entries" do
    assert_raise RuntimeError, ~r/could not find entry/, fn ->
      Mesa.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end

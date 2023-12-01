defmodule Mesa.RouterTest do
  use ExUnit.Case, async: true

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

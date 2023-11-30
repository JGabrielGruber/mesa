defmodule MesaServerTest do
  use ExUnit.Case
  doctest MesaServer

  test "greets the world" do
    assert MesaServer.hello() == :world
  end
end

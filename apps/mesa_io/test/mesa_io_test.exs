defmodule MesaIoTest do
  use ExUnit.Case
  doctest MesaIo

  setup do
    dir = System.tmp_dir!() |> Path.join("mesa_io_test")
    File.rm_rf!(dir)
    File.mkdir!(dir)
    %{dir: dir}
  end

  test "IO interaction", %{dir: dir} do
    assert MesaIo.list(dir) == []
    bar = Path.join(dir, "bar")
    assert MesaIo.create(bar) == :ok
    assert MesaIo.create(bar, "test") == :ok
    assert MesaIo.create(dir, "foo") == :ok
    foo = Path.join(dir, "foo")
    assert MesaIo.list(dir) == [Path.join(bar, "test"), foo]
    assert MesaIo.check(foo) == <<218, 57, 163, 238, 94, 107, 75, 13, 50, 85, 191, 239, 149, 96, 24, 144, 175, 216, 7, 9>>
  end

end

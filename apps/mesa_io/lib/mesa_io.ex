defmodule MesaIo do
  @moduledoc """
  Documentation for `MesaIo`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MesaIo.hello()
      :world

  """
  def hello do
    :world
  end

  def list(dir) do
    Path.join(dir, "**")
      |>Path.wildcard(match_dot: true)
      |> Enum.filter(&File.regular?/1)
  end

  def create(dir, file \\ nil)
  def create(dir, nil) do
    File.mkdir(dir)
  end
  def create(dir, file) do
    File.mkdir(dir)
    Path.join(dir, file) |> File.touch()
  end

  def check(dir) do
    file = File.stat!(dir)
    if file.size > 100000000 do
      raise {:error, :etoobig}
    end
    stream = File.stream!(dir, [:read])
    :crypto.hash(:sha, Enum.to_list(stream))
  end

end

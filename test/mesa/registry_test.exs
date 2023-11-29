defmodule Mesa.RegistryTest do
  use ExUnit.Case, async: true

  setup context do
    _ = start_supervised!({Mesa.Registry, name: context.test})
    %{registry: context.test}
  end

  test "spawns buckets", %{registry: registry} do
    assert Mesa.Registry.lookup(registry, "shopping") == :error

    Mesa.Registry.create(registry, "shopping")
    assert {:ok, bucket} = Mesa.Registry.lookup(registry, "shopping")

    Mesa.Bucket.put(bucket, "milk", 1)
    assert Mesa.Bucket.get(bucket, "milk") == 1
  end

  test "removes buckets on exit", %{registry: registry} do
    Mesa.Registry.create(registry, "shopping")
    {:ok, bucket} = Mesa.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)

    _ = Mesa.Registry.create(registry, "bogus")
    assert Mesa.Registry.lookup(registry, "shopping") == :error
  end

  test "removes buckets on crash", %{registry: registry} do
    Mesa.Registry.create(registry, "shopping")
    {:ok, bucket} = Mesa.Registry.lookup(registry, "shopping")

    # Stops the bucket with non-normal reason
    Agent.stop(bucket, :shutdown)

    _ = Mesa.Registry.create(registry, "bogus")
    assert Mesa.Registry.lookup(registry, "shopping") == :error
  end
end

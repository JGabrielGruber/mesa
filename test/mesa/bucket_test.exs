defmodule Mesa.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(Mesa.Bucket)
    %{bucket: bucket}
  end

  test "stores value by key", %{bucket: bucket} do
    assert Mesa.Bucket.get(bucket, "milk") == nil

    Mesa.Bucket.put(bucket, "milk", 3)
    assert Mesa.Bucket.get(bucket, "milk") == 3

    assert Mesa.Bucket.delete(bucket, "milk") == 3
  end
end

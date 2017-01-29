defmodule TubexTest.Utils do
  use ExUnit.Case

  test "encode_body" do
    assert Tubex.Utils.encode_body(
      [key: "value"]
    )  === "key=value"
  end

  test "custom impl" do
    assert Tubex.Utils.encode_body(
      [key: %{ a: 42 }]
    )  === "key[a]=42"
  end

  test "nested custom impl" do
    assert Tubex.Utils.encode_body(
      [key: %{ a: %{ b: 42 } }]
    )  === "key[a][b]=42"
  end
end

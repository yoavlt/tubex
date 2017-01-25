defmodule TubexTest.Utils do
  use ExUnit.Case

  test "encode_body" do
    assert Tubex.Utils.encode_body(
      [key: "value"]
    )  === "key=value"
  end
end

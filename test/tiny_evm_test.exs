defmodule TinyEvmTest do
  use ExUnit.Case
  doctest TinyEvm

  test "greets the world" do
    assert TinyEvm.hello() == :world
  end
end

defmodule QasMicroTest do
  use ExUnit.Case
  doctest QasMicro

  test "greets the world" do
    assert QasMicro.hello() == :world
  end
end

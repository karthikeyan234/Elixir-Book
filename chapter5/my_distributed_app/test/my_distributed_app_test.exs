defmodule MyDistributedAppTest do
  use ExUnit.Case
  doctest MyDistributedApp

  test "greets the world" do
    assert MyDistributedApp.hello() == :world
  end
end

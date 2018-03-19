defmodule WillSimulatorTest do
  use ExUnit.Case
  doctest WillSimulator

  test "greets the world" do
    assert WillSimulator.hello() == :world
  end
end

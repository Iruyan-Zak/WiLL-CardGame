defmodule WillSimulatorTest do
  use ExUnit.Case
  doctest WillSimulator

  import WillSimulator.State

  @state %{default_state() | deck: [1,2,3]}

  test "greets the world" do
    assert WillSimulator.hello() == :world
  end

  test "draw" do
    assert 1 in draw(@state)[:hand]
    assert 2 in draw(@state)[:deck]
    assert not (1 in draw(@state)[:deck])
  end
end

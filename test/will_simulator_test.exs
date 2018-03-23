defmodule WillSimulatorTest do
  use ExUnit.Case
  doctest WillSimulator

  import WillSimulator.State

  @states %{0 => %{default_state() | deck: [1,2,3]},
            1 => %{default_state() | deck: [4,5,6]}}

  test "greets the world" do
    assert WillSimulator.hello() == :world
  end

  test "draw" do
    assert 1 in draw(@states, 0)[0][:hand]
    assert not (4 in draw(@states, 1)[1][:deck])
    assert not (4 in draw(@states, 0)[1][:hand])
  end
end

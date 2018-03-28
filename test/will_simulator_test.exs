defmodule WillSimulatorTest do
  use ExUnit.Case
  doctest WillSimulator

  import WillSimulator.State
  import WillSimulator.StateHelper
  import WillSimulator.Utils

  @state %{default_state() | deck: [1,2,3]}

  test "greets the world" do
    assert WillSimulator.hello() == :world
  end

  test "draw" do
    assert 1 in draw(@state)[:hand]
    assert 2 in draw(@state)[:deck]
    assert not (1 in draw(@state)[:deck])
  end

  test "conditional select" do
    selector = &(conditional_select(&1, 0..9,
          fn(list) -> Enum.sum(list) < 20 end))
    {picks, rests} = selector.(0..3)
    assert length(picks) == 4
    assert length(rests) == 6
    assert :condition_not_satisfied === catch_throw selector.(7..9)
  end

  test "select" do
    {picks, rests} = select([0,0,2,3], 4..8, 2)
    assert 6 in picks
    assert not(7 in picks)
    assert length(picks) == 2
    assert length(rests) == 3
  end

  test "utils" do
    assert show_enum_with_indices([1,2]) === "0: 1\n1: 2"
    assert parse_integers("1 2") === [1,2]
  end
end

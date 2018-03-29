defmodule WillSimulator.Player do
  def you(turn) do
    player(turn, 1)
  end

  def opponent(turn) do
    player(turn, 0)
  end

  defp player(turn, side) do
    use Bitwise, only_operators: true
    (turn &&& 1) ^^^ side
  end
end

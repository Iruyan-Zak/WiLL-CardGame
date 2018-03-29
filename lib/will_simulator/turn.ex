defmodule WillSimulator.Turn do
  import WillSimulator.State
  import WillSimulator.StateHelper
  import WillSimulator.Player

  def do_turn(game) do
    game
    |> beginning_of_turn
    |> start_step
    |> draw_step
    |> IO.inspect  # for debug
    |> mana_step
    |> main_step
    |> end_step
  end

  defp beginning_of_turn(game) do
    update_in(game.turn, &(&1+1))
  end

  defp start_step(game) do
    game
  end

  defp draw_step(game) do
    update_in(game[:states][you(game.turn)],
      fn state -> state |> draw end)
  end

  defp mana_step(game) do
    update_in(game[:states][you(game.turn)],
      fn state ->
        state |> move(:hand, :mana, fn hands ->
          conditional_select(hands, &(length(&1) <= 1))
        end)
      end)
  end

  defp main_step(game) do
    game
  end

  defp end_step(game) do
    game
  end
end

defmodule WillSimulator do
  @moduledoc """
  Documentation for WillSimulator.
  """

  @doc """
  Hello world.

  ## Examples

      iex> WillSimulator.hello
      :world

  """
  def hello do
    :world
  end

  def play do
    import WillSimulator.State

    state = %{default_state() |
              deck: 1..40 |> Enum.to_list}
    game = %{
      :states => %{
        0 => Map.update!(state, :deck, &Enum.shuffle/1),
        1 => Map.update!(state, :deck, &Enum.shuffle/1)},
      :turn => 0,
    }
    game = update_in(game[:states][0], &(draw(&1, 7)))
    game = update_in(game[:states][1], &(draw(&1, 7)))

    main game
  end

  def main(game) do
    import WillSimulator.Turn

    IO.inspect(game[:states])

    game
    |> do_turn
    |> main
  end
end

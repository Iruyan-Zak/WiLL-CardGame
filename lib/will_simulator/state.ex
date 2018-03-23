defmodule WillSimulator.State do
  def default_state do
    %{deck: [], hand: [], field: [], mana: [], lake: [], scrap: []}
  end

  """
  state = %{0 => @state, 1 => @state}
  """

  def move(states, player, from, to, selector) do
    {picks, rests} = selector.(states[player][from])
    states = put_in(states[player][from], rests)
    update_in(states[player][to], &(Enum.concat(picks, &1)))
  end

  def draw(states, player, count \\ 1) do
    move(states, player, :deck, :hand, &(Enum.split(&1, count)))
  end
end

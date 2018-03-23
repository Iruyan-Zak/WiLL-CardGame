defmodule WillSimulator.State do
  def default_state do
    %{deck: [], hand: [], field: [], mana: [], lake: [], scrap: []}
  end

  def move(state, from, to, selector) do
    {picks, rests} = selector.(state[from])
    state = put_in(state[from], rests)
    update_in(state[to], &(Enum.concat(picks, &1)))
  end

  def draw(state, count \\ 1) do
    move(state, :deck, :hand, &(Enum.split(&1, count)))
  end
end

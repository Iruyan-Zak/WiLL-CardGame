defmodule WillSimulator.StateHelper do
  def conditional_select(index_stream, enum, predicate) do
    picked = with [picked | _] <-
      index_stream
      |> Stream.uniq
      |> Stream.take_while(&(&1 !== :end))
      |> Stream.map(&(Enum.at(enum, &1)))
      |> Stream.reject(&(&1 === nil))
      |> Stream.scan([], &[&1 | &2])
      |> Stream.take_while(&(predicate.(&1)))
      |> Enum.reverse
    do
      picked
    end
    {picked, Enum.to_list(enum) -- picked}
  end

  def select(index_stream, enum, count \\ 1) do
    picked =
      index_stream
      |> Stream.uniq
      |> Stream.map(&(Enum.at(enum, &1)))
      |> Stream.reject(&(&1 === nil))
      |> Enum.take(count)

    {picked, Enum.to_list(enum) -- picked}
  end
end

defmodule WillSimulator.StateHelper do
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

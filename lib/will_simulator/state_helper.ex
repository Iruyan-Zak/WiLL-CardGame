defmodule WillSimulator.StateHelper do
  def conditional_select(index_stream, enum, predicate) do
    picked =
      index_stream
      |> Stream.uniq
      |> Stream.map(&(Enum.at(enum, &1)))
      |> Stream.reject(&(&1 === nil))
      |> Enum.to_list

    if predicate.(picked) do
      {picked, Enum.to_list(enum) -- picked}
    else
      throw(:condition_not_satisfied)
    end
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

defmodule WillSimulator.StateHelper do
  @input_source Application.get_env(:will_simulator, :input_source)

  def create_input(generator) do
    input = with [atom | vals] <-
      generator.()
      |> Stream.uniq
      |> Stream.scan([],&[&1 | &2])
      |> Stream.drop_while(fn [head | _] -> not(head === :end) end)
      |> Stream.take(1)
      |> Stream.map(fn list -> list |> Enum.take_while(&(&1 !== :reset)) end)
      |> Enum.at(0)
    do
      {atom, vals}
    end

    case input do
      {:end, vals} -> {:ok, vals |> Enum.filter(&(not is_atom(&1))) |> Enum.reverse}
      _ -> :error
    end
  end

  def conditional_select(index_generator \\ @input_source, enum, predicate) do
    candidate = Enum.to_list(enum)
    selected = with {:ok, vals} <- create_input(index_generator)
    do
      vals
      |> Stream.map(&(Enum.at(enum, &1)))
      |> Enum.reject(&(&1 === nil))
    end

    case selected do
      :error -> :error
      _vals ->
        if predicate.(selected) do
          {selected, candidate -- selected}
        else
          :error
        end
    end
  end

  def select(index_generator \\ @input_source, enum, count \\ 1) do
    conditional_select(index_generator, enum, &(length(&1) === count))
  end
end

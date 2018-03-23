defmodule WillSimulator.StateHelper do
  def select(enum, selector, count \\ 1) do
    candidate = Enum.filter(enum, selector)
    IO.puts("Choose #{count} cards.")
    IO.puts(show_enum_with_indices(candidate))

    picked =
      read_integers()
      |> Stream.uniq
      |> Stream.map(&(Enum.at(candidate, &1)))
      |> Stream.reject(&(&1 === nil))
      |> Enum.take(count)

    {picked, candidate -- picked}
  end

  defp read_integers() do
    Stream.repeatedly(fn ->
      IO.gets("Input numbers with space separated > ")
      |> parse_integers
    end)
    |> Stream.concat
  end

  defp show_enum_with_indices(enum) do
    enum
    |> Enum.with_index
    |> Enum.map(fn {val, ind} -> "#{ind}: #{val}" end)
    |> Enum.join("\n")
  end

  defp parse_integers(string) do
    string
    |> String.trim
    |> String.split(" ")
    |> Stream.concat([])
    |> Stream.map(&(String.to_integer(&1)))
  end
end

defmodule WillSimulator.CLI do
  import WillSimulator.Utils

  def read_atoms_or_integers() do
    Stream.repeatedly(fn ->
      IO.gets("Input numbers or texts with space separated > ")
      |> parse_atoms_or_integers
    end)
    |> Stream.concat
  end

  def select_console(candidate, count) do
    IO.puts("Choose #{count} cards.")
    IO.puts(show_enum_with_indices(candidate))
  end
end

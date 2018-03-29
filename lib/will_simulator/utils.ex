defmodule WillSimulator.Utils do
  def show_enum_with_indices(enum) do
    enum
    |> Enum.with_index
    |> Enum.map(fn {val, ind} -> "#{ind}: #{val}" end)
    |> Enum.join("\n")
  end

  def parse_atoms_or_integers(string) do
    string
    |> String.trim
    |> String.split(" ")
    |> Enum.map(fn str ->
      case Integer.parse(str) do
        {val, _} -> val
        _ -> String.to_atom(str)
      end
    end)
  end
end

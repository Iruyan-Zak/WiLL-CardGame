defmodule WillSimulator.Utils do
  def show_enum_with_indices(enum) do
    enum
    |> Enum.with_index
    |> Enum.map(fn {val, ind} -> "#{ind}: #{val}" end)
    |> Enum.join("\n")
  end

  def parse_integers(string) do
    string
    |> String.trim
    |> String.split(" ")
    |> Enum.map(&(String.to_integer(&1)))
  end
end

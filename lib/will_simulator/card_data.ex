defmodule WillSimulator.CardData do
  def load_from_csv(csv_name) do
    csv_name
    |> File.stream!
    |> Stream.drop(1)  # Skip header
    |> CSV.decode!
    |> Stream.map( &( Enum.at(&1, 4) ) )
    |> Enum.to_list
  end
end

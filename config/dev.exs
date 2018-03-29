use Mix.Config

config :will_simulator,
  input_source: quote(do: unquote(&WillSimulator.CLI.read_atoms_or_integers/0))

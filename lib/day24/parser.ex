defmodule AoC2024.Day24.Parser do
  @moduledoc false

  import NimbleParsec

  new_line = ascii_string([?\n], 1)
  gate = ascii_string([?a..?z, ?0..?9], 3)

  wire =
    gate
    |> ignore(string(": "))
    |> integer(1)
    |> ignore(new_line)
    |> reduce({List, :to_tuple, []})

  connection =
    gate
    |> ignore(string(" "))
    |> choice([
      string("AND"),
      string("OR"),
      string("XOR")
    ])
    |> ignore(string(" "))
    |> concat(gate)
    |> reduce({:to_input, []})
    |> ignore(string(" -> "))
    |> concat(gate)
    |> ignore(optional(new_line))
    |> reduce({List, :to_tuple, []})

  program =
    repeat(wire)
    |> wrap()
    |> ignore(new_line)
    |> wrap(repeat(connection))

  # x01: 0
  # y04: 1

  # ntg XOR fgs -> mjb
  # y02 OR x01 -> tnw
  defparsec(:parse, program |> eos())

  def parse_program(data) do
    data
    |> parse()
    |> to_program()
  end

  defp to_program({:ok, [wires, connections], "", _, _, _}),
    do: {
      Map.new(wires),
      connections
    }

  defp to_input([g1, "AND", g2]), do: {&Bitwise.band/2, g1, g2}
  defp to_input([g1, "OR", g2]), do: {&Bitwise.bor/2, g1, g2}
  defp to_input([g1, "XOR", g2]), do: {&Bitwise.bxor/2, g1, g2}
end

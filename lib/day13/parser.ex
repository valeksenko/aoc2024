defmodule AoC2024.Day13.Parser do
  @moduledoc false

  import NimbleParsec

  new_line = ascii_string([?\n], 1)

  move =
    ignore(string("X+"))
    |> integer(min: 1)
    |> ignore(string(", Y+"))
    |> integer(min: 1)
    |> ignore(new_line)
    |> reduce({List, :to_tuple, []})

  prize =
    ignore(string("X="))
    |> integer(min: 1)
    |> ignore(string(", Y="))
    |> integer(min: 1)
    |> ignore(optional(new_line))
    |> reduce({List, :to_tuple, []})

  rule =
    ignore(string("Button A: "))
    |> concat(move)
    |> ignore(string("Button B: "))
    |> concat(move)
    |> wrap()
    |> ignore(string("Prize: "))
    |> concat(prize)
    |> reduce({List, :to_tuple, []})
    |> ignore(optional(new_line))

  # Button A: X+94, Y+34
  # Button B: X+22, Y+67
  # Prize: X=8400, Y=5400
  defparsec(:parse, repeat(rule) |> eos())

  def parse_rules(data) do
    data
    |> parse()
    |> to_rules()
  end

  defp to_rules({:ok, rules, "", _, _, _}), do: rules
end

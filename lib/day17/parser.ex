defmodule AoC2024.Day17.Parser do
  @moduledoc false

  import NimbleParsec

  new_line = ascii_string([?\n], 1)

  register =
    ignore(string("Register "))
    |> ascii_string([?A..?C], 1)
    |> ignore(string(": "))
    |> integer(min: 1)
    |> ignore(new_line)
    |> reduce({List, :to_tuple, []})

  op =
    integer(min: 1)
    |> ignore(optional(string(",")))

  program =
    repeat(register)
    |> wrap()
    |> ignore(new_line)
    |> ignore(string("Program: "))
    |> wrap(repeat(op))
    |> ignore(optional(new_line))

  # Register A: 729
  # Register B: 0
  # Register C: 0

  # Program: 0,1,5,4,3,0
  defparsec(:parse, program |> eos())

  def parse_program(data) do
    data
    |> parse()
    |> to_program()
  end

  defp to_program({:ok, [regs, ops], "", _, _, _}),
    do: {
      Map.new(regs),
      ops
    }
end

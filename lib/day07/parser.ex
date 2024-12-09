defmodule AoC2024.Day07.Parser do
  @moduledoc false

  import NimbleParsec

  numbers =
    repeat(
      ignore(string(" "))
      |> integer(min: 1)
    )
    |> wrap()

  equations =
    integer(min: 1)
    |> ignore(string(":"))
    |> concat(numbers)
    |> reduce({List, :to_tuple, []})

  # 3267: 81 40 27
  defparsec(:parse, equations |> eos())

  def parse_equations(data) do
    data
    |> parse()
    |> to_equations()
  end

  defp to_equations({:ok, [equations], "", _, _, _}), do: equations
end

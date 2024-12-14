defmodule AoC2024.Day14.Parser do
  @moduledoc false

  import NimbleParsec

  signed =
    optional(ascii_char([?-]))
    |> integer(min: 1)
    |> post_traverse({:sign_int, []})

  robot =
    ignore(string("p="))
    |> integer(min: 1)
    |> ignore(string(","))
    |> integer(min: 1)
    |> reduce({List, :to_tuple, []})
    |> concat(
      ignore(string(" v="))
      |> concat(signed)
      |> ignore(string(","))
      |> concat(signed)
      |> reduce({List, :to_tuple, []})
    )
    |> reduce({List, :to_tuple, []})

  # p=0,4 v=3,-3
  defparsec(:parse, robot |> eos())

  def parse_robot(input) do
    input
    |> parse()
    |> to_robot()
  end

  defp to_robot({:ok, [r], "", _, _, _}), do: r

  defp sign_int(_, [int, _neg], context, _, _), do: {[int * -1], context}
  defp sign_int(_, res, context, _, _), do: {res, context}
end

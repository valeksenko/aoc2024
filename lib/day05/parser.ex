defmodule AoC2024.Day05.Parser do
  import NimbleParsec

  new_line = ascii_string([?\n], 1)
  page = integer(min: 1)

  ordering =
    page
    |> ignore(string("|"))
    |> concat(page)
    |> reduce({List, :to_tuple, []})
    |> ignore(new_line)

  pages =
    page
    |> repeat(
      ignore(optional(string(",")))
      |> concat(page)
    )
    |> ignore(optional(new_line))
    |> wrap()

  rules =
    repeat(ordering)
    |> wrap()
    |> ignore(new_line)
    |> wrap(repeat(pages))

  # 53|13
  #
  # 75,47,61
  defparsec(:parse, rules |> eos())

  def parse_rules(data) do
    data
    |> parse()
    |> to_rules()
  end

  defp to_rules({:ok, [orderings, pages], "", _, _, _}),
    do: {
      orderings,
      pages
    }
end

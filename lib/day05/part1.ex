defmodule AoC2024.Day05.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/5
  """
  import AoC2024.Day05.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> parse_rules()
    |> right_order()
    |> Enum.map(&middle_page/1)
    |> Enum.sum()
  end

  defp right_order({orderings, pages}) do
    pages
    |> Enum.filter(&ordered?(&1, orderings))
  end

  defp ordered?(pages, orderings) do
    orderings
    |> Enum.all?(&match_order?(&1, pages))
  end

  defp match_order?({page1, page2}, pages) do
    case {Enum.find_index(pages, &(&1 == page1)), Enum.find_index(pages, &(&1 == page2))} do
      {nil, _} -> true
      {_, nil} -> true
      {i1, i2} -> i1 < i2
    end
  end

  defp middle_page(pages), do: Enum.at(pages, floor(length(pages) / 2))
end

defmodule AoC2024.Day05.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/5#part2
  """
  import AoC2024.Day05.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day
  
  def run(data) do
    data
    |> parse_rules()
    |> correct_order()
    |> Enum.map(&middle_page/1)
    |> Enum.sum()
  end

  defp correct_order({orderings, pages}) do
    pages
    |> Enum.reject(&(ordered?(&1, orderings)))
    |> Enum.map(&(reorder(&1, orderings)))
  end

  defp reorder([page | pages], orderings) do
    pages
    |> Enum.reduce([page], &(order(&1, [], &2, orderings)))
  end

  defp order(page, left, [], _), do: left ++ [page]
  defp order(page, left, right, orderings) do
    if ordered?([page | right], orderings),
      do: left ++ [page | right],
      else: order(page, left ++ [hd(right)], tl(right), orderings)
  end

  defp ordered?(pages, orderings) do
    orderings
    |> Enum.all?(&match_order?(&1, pages))
  end

  defp match_order?({page1, page2}, pages) do
    case { Enum.find_index(pages, &(&1== page1)), Enum.find_index(pages, &(&1== page2)) } do
      { nil, _ } -> true
      { _, nil } -> true
      { i1, i2 } -> i1 < i2
    end
  end

  defp middle_page(pages), do: Enum.at(pages, floor(length(pages) / 2))
end

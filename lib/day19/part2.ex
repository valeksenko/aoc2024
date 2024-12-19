defmodule AoC2024.Day19.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/19#part2
  """

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> parse()
    |> valid_designs()
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  defp valid_designs({patterns, designs}) do
    designs
    |> Enum.map(&all_matches(&1, patterns))
  end

  defp all_matches(design, patterns) do
    {true, MapSet.new()}
    |> Stream.iterate(&match(design, patterns, elem(&1, 1)))
    |> Stream.take_while(&elem(&1, 0))
    |> Enum.to_list()
    |> List.last()
    |> elem(1)
  end

  defp match(design, patterns, collected) do
    goal = fn d -> Enum.join(d) == design && !MapSet.member?(collected, d) end
    # we can't estimate, so using it as a Dijkstra's
    cost = fn _, _ -> 1 end

    add = fn d ->
      patterns
      |> Enum.map(&(d ++ [&1]))
      |> Enum.filter(&String.starts_with?(design, Enum.join(&1)))
    end

    Astar.astar({add, cost, cost}, [], goal)
    |> (fn d ->
          if Enum.empty?(d),
            do: {false, collected},
            else: {true, MapSet.put(collected, List.last(d))}
        end).()
  end

  defp parse([patterns | designs]), do: {patterns |> String.split(", "), designs}
end

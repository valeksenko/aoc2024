defmodule AoC2024.Day19.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/19
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> parse()
    |> valid_designs()
    |> length()
  end

  defp valid_designs({patterns, designs}) do
    designs
    |> Enum.reject(&(match(&1, patterns) |> Enum.empty?()))
  end

  defp match(design, patterns) do
    goal = fn d -> d == design end
    # we can't estimate, so using it as a Dijkstra's
    cost = fn _, _ -> 1 end

    add = fn d ->
      patterns
      |> Enum.map(&(d <> &1))
      |> Enum.filter(&String.starts_with?(design, &1))
    end

    Astar.astar({add, cost, cost}, "", goal)
  end

  defp parse([patterns | designs]), do: {patterns |> String.split(", "), designs}
end

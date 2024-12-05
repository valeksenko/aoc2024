defmodule AoC2024.Day04.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/4#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @positions [
    %{
      {0, 0} => "M",
      {0, 2} => "M",
      {1, 1} => "A",
      {2, 0} => "S",
      {2, 2} => "S"
    },
    %{
      {0, 0} => "M",
      {0, 2} => "S",
      {1, 1} => "A",
      {2, 0} => "M",
      {2, 2} => "S"
    },
    %{
      {0, 0} => "S",
      {0, 2} => "M",
      {1, 1} => "A",
      {2, 0} => "S",
      {2, 2} => "M"
    },
    %{
      {0, 0} => "S",
      {0, 2} => "S",
      {1, 1} => "A",
      {2, 0} => "M",
      {2, 2} => "M"
    },
  ]

  def run(data) do
    data
    |> to_grid()
    |> word_search()
    |> Enum.sum()
  end

  defp word_search(grid) do
    grid
    |> Map.keys()
    |> Enum.map(&(counts(&1, grid)))
  end

  defp counts(start, grid) do
    @positions
    |> Enum.count(&(match(start, &1, grid)))
  end

  defp match({x, y}, word, grid) do
    word
    |> Enum.all?(fn {{xd, yd}, letter} -> grid[{x + xd, y + yd}] == letter end)
  end

  defp to_grid(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, grid) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(grid, fn {v, x}, m -> Map.put(m, {x, y}, v) end)
  end
end

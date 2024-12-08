defmodule AoC2024.Day04.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/4
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @word ["X", "M", "A", "S"]
  @neighbors for x <- -1..1, y <- -1..1, {x, y} != {0, 0}, do: {x, y}

  def run(data) do
    data
    |> to_grid()
    |> word_search()
    |> length()
  end

  defp word_search(grid) do
    grid
    |> Enum.flat_map(&run_search(&1, grid))
  end

  defp run_search(start, grid) do
    @neighbors
    |> Enum.flat_map(&search({[], @word, []}, start, &1, grid))
  end

  defp search({found, [], current}, _, _, _), do: [current | found]

  defp search({found, [letter | reminder], current}, {{x, y}, letter}, {xd, yd}, grid),
    do:
      search(
        {found, reminder, [{x, y} | current]},
        {{x + xd, y + yd}, grid[{x + xd, y + yd}]},
        {xd, yd},
        grid
      )

  defp search({found, _, _}, _, _, _), do: found

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

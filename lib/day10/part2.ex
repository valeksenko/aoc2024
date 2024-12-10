defmodule AoC2024.Day10.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/10#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @start 0
  @finish 9

  @neighbors [
    {0, -1},
    {0, 1},
    {1, 0},
    {-1, 0}
  ]

  def run(data) do
    data
    |> to_map()
    |> scores()
    |> Enum.sum()
  end

  defp scores(map) do
    map
    |> Enum.filter(&(elem(&1, 1) == @start))
    |> Enum.map(fn {p, id} -> calculate_score(0, p, id, map) end)
  end

  defp calculate_score(found, {x, y}, id, map) do
    @neighbors
    |> Enum.map(fn {xd, yd} -> {x + xd, y + yd} end)
    |> Enum.reduce(found, fn pos, t -> score(t, id + 1, map[pos], pos, map) end)
  end

  defp score(found, @finish, @finish, _, _), do: found + 1
  defp score(found, id, id, pos, map), do: calculate_score(found, pos, id, map)
  defp score(found, _, _, _, _), do: found

  defp to_map(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end

  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m -> Map.put(m, {x, y}, String.to_integer(v)) end)
  end
end

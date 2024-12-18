defmodule AoC2024.Day18.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/18
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @neighbors [
    {0, -1},
    {0, 1},
    {1, 0},
    {-1, 0}
  ]

  def run(data, max_pos \\ 70, initial \\ 1024) do
    data
    |> Enum.map(&to_tuples/1)
    |> Enum.take(initial)
    |> MapSet.new()
    |> find_path(max_pos)
    |> length()
  end

  defp find_path(mem, max_pos) do
    goal = fn pos -> pos == {max_pos, max_pos} end
    # we can't estimate, so using it as a Dijkstra's
    cost = fn _, _ -> 1 end

    move = fn {x, y} ->
      @neighbors
      |> Enum.map(fn {xd, yd} -> {x + xd, y + yd} end)
      |> Enum.reject(&prune?(&1, max_pos, mem))
    end

    Astar.astar({move, cost, cost}, {0, 0}, goal)
  end

  defp prune?({x, y}, max_pos, mem) when x in 0..max_pos//1 and y in 0..max_pos//1,
    do: MapSet.member?(mem, {x, y})

  defp prune?(_, _, _), do: true

  defp to_tuples(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end

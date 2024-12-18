defmodule AoC2024.Day18.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/18#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @neighbors [
    {0, -1},
    {0, 1},
    {1, 0},
    {-1, 0}
  ]

  def run(data, max_pos \\ 70) do
    data
    |> Enum.map(&to_tuples/1)
    |> find_blocked(max_pos)
  end

  defp find_blocked(mem, max_pos) do
    mem
    |> Enum.reduce_while([], fn pos, corrupted ->
      if find_path([pos | corrupted], max_pos) |> Enum.empty?(),
        do: {:halt, pos},
        else: {:cont, [pos | corrupted]}
    end)
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
    do: Enum.member?(mem, {x, y})

  defp prune?(_, _, _), do: true

  defp to_tuples(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end

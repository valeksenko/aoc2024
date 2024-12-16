defmodule AoC2024.Day16.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/16
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @wall "#"

  @north {0, -1}
  @south {0, 1}
  @east {1, 0}
  @west {-1, 0}

  @clockwise %{
    @north => @east,
    @east => @south,
    @south => @west,
    @west => @north
  }

  @counerclockwise %{
    @north => @west,
    @east => @north,
    @south => @east,
    @west => @south
  }

  def run(data) do
    data
    |> to_maze()
    |> find_path()
  end

  defp find_path({start, finish, maze}) do
    goal = fn {pos, _, _} -> pos == finish end
    move_cost = fn _, {_, _, cost} -> cost end
    # we can't estimate, so using it as a Dijkstra's
    estimated_cost = fn _, _ -> 1 end

    move = fn {pos, dir, _} ->
      moves(pos, dir) |> Enum.reject(&(Map.get(maze, elem(&1, 0)) == @wall))
    end

    Astar.astar({move, move_cost, estimated_cost}, {start, @east, 0}, goal)
    |> Enum.map(&elem(&1, 2))
    |> Enum.sum()
  end

  defp moves({x, y}, {xd, yd}) do
    [
      {{x + xd, y + yd}, {xd, yd}, 1},
      {{x, y}, @clockwise[{xd, yd}], 1_000},
      {{x, y}, @counerclockwise[{xd, yd}], 1_000}
    ]
  end

  defp to_maze(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
    |> find_endpoints()
  end

  defp find_endpoints(maze) do
    with {start, _} <- Enum.find(maze, fn {_, v} -> v == "S" end),
         {finish, _} <- Enum.find(maze, fn {_, v} -> v == "E" end) do
      {start, finish, maze |> Map.delete(start) |> Map.delete(finish)}
    end
  end

  defp add_row({row, y}, maze) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(maze, fn {v, x}, m -> if v == ".", do: m, else: Map.put(m, {x, y}, v) end)
  end
end

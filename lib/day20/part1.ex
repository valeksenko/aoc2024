defmodule AoC2024.Day20.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/20
  """

  import Heap

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @neighbors [
    {0, -1},
    {0, 1},
    {1, 0},
    {-1, 0}
  ]

  def run(data, saves \\ 100) do
    data
    |> to_racetrack()
    |> cheat_savings()
    |> Enum.count(&(&1 >= saves))
  end

  defp cheat_savings({racetrack, start, finish, {max_x, max_y}}) do
    with min_score <- find_path(racetrack, start, finish, max_x * max_y) do
      racetrack
      |> MapSet.reject(fn {x, y} -> x == 0 || y == 0 || x == max_x || y == max_y end)
      |> Enum.map(fn e -> racetrack |> MapSet.delete(e) |> find_path(start, finish, min_score) end)
      |> Enum.map(&(min_score - &1))
    end
  end

  defp find_path(racetrack, start, finish, min_score) do
    move = fn {x, y} ->
      @neighbors
      |> Enum.map(fn {xd, yd} -> {x + xd, y + yd} end)
      |> Enum.reject(&MapSet.member?(racetrack, &1))
    end

    dijkstra(Heap.min() |> Heap.push({0, start}), MapSet.new(), finish, move, min_score)
  end

  defp dijkstra(heap, resolved, finish, move, min_score) do
    case Heap.split(heap) do
      {nil, _} ->
        min_score

      {{node_cost, node}, rest} ->
        cond do
          node == finish ->
            node_cost

          node_cost > min_score ->
            node_cost

          MapSet.member?(resolved, node) ->
            dijkstra(rest, resolved, finish, move, min_score)

          true ->
            node
            |> move.()
            |> Enum.reduce(heap, &Heap.push(&2, {node_cost + 1, &1}))
            |> dijkstra(MapSet.put(resolved, node), finish, move, min_score)
        end
    end
  end

  defp to_racetrack(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
    |> find_endpoints()
  end

  defp find_endpoints(racetrack) do
    with {start, _} <- Enum.find(racetrack, fn {_, v} -> v == "S" end),
         {finish, _} <- Enum.find(racetrack, fn {_, v} -> v == "E" end) do
      {
        racetrack |> Map.delete(start) |> Map.delete(finish) |> Map.keys() |> MapSet.new(),
        start,
        finish,
        racetrack |> Map.keys() |> Enum.max()
      }
    end
  end

  defp add_row({row, y}, racetrack) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(racetrack, fn {v, x}, m -> if v == ".", do: m, else: Map.put(m, {x, y}, v) end)
  end
end

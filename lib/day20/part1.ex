defmodule AoC2024.Day20.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/20
  """

  import AoC2024.Astar

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
    |> result(saves)
  end

  defp cheat_savings(map) do
    map
    |> find_path({[], []})
    |> Stream.iterate(&find_path(map, &1))
    |> Stream.drop_while(&(elem(&1, 0) != :halt))
    |> Enum.take(1)
    |> IO.inspect()
    |> hd()
    |> elem(1)
    |> Enum.reverse()
  end

  defp result([no_cheat | cheats], saves) do
    cheats
    |> Enum.count(&(no_cheat - &1 >= saves))
  end

  defp find_path({start, finish, max_x, max_y, racetrack}, {scores, total_visited}) do
    min_score = List.last(scores)

    goal = fn {pos, _, _} -> pos == finish end
    move_cost = fn _, {_, score, _} -> score end

    # move_cost = fn {p1, _, _}, {p2, score, _} -> (inspect(racetrack, p1, p2, max_x, max_y); score) end
    # we can't estimate, so using it as a Dijkstra's
    estimated_cost = fn _, _ -> 1 end

    move = fn {pos, _, cheated}, visited ->
      # if Enum.member?(visited, {{9, 1}, 2, true}) do
      #   inspect(racetrack, visited |> Enum.map(&elem(&1, 1)) |> Enum.sum(), pos, max_x, max_y)
      #   IO.inspect(Enum.map(visited, &elem(&1, 0)))
      #   moves(pos, racetrack, cheated) |> Enum.reject(fn {pos, _, _} -> prune?(pos, max_x, max_y, MapSet.member?(racetrack, pos), min_score, visited, total_visited) end) |> IO.inspect(label: "pruned")
      # end
      # |> IO.inspect(label: "pruned")
      moves(pos, racetrack, cheated)
      |> Enum.reject(fn {pos, _, _} ->
        prune?(
          pos,
          max_x,
          max_y,
          MapSet.member?(racetrack, pos),
          min_score,
          visited,
          total_visited
        )
      end)
    end

    astar({move, move_cost, estimated_cost}, {start, 0, min_score == nil}, goal)
    |> Enum.reverse()
    |> (fn s ->
          if Enum.empty?(s),
            do: {:halt, scores},
            else:
              {[s |> Enum.map(&elem(&1, 1)) |> Enum.sum() | scores],
               [Enum.map(s, &elem(&1, 0)) | total_visited]}
        end).()
  end

  defp moves({x, y}, racetrack, cheated) do
    @neighbors
    |> Enum.map(fn {xd, yd} -> {{x + xd, y + yd}, {xd, yd}} end)
    |> Enum.map(fn {{xn, yn}, {xd, yd}} ->
      if MapSet.member?(racetrack, {xn, yn}) && !cheated,
        do: {{xn + xd, yn + yd}, 2, true},
        else: {{xn, yn}, 1, cheated}
    end)
  end

  defp prune?(_, _, _, true, _, _, _), do: true
  defp prune?({x, _}, max_x, _, _, _, _, _) when x not in 0..max_x//1, do: true
  defp prune?({_, y}, _, max_y, _, _, _, _) when y not in 0..max_y//1, do: true

  defp prune?(pos, _, _, _, min_score, visited, total_visited) do
    if min_score && visited |> Enum.map(&elem(&1, 1)) |> Enum.sum() > min_score,
      do: true,
      else:
        Enum.member?(total_visited, [pos | visited |> Enum.map(&elem(&1, 0)) |> Enum.reverse()])
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
        start,
        finish,
        racetrack |> Enum.map(fn {{x, _}, _} -> x end) |> Enum.max(),
        racetrack |> Enum.map(fn {{_, y}, _} -> y end) |> Enum.max(),
        racetrack |> Map.delete(start) |> Map.delete(finish) |> Map.keys() |> MapSet.new()
      }
    end
  end

  defp add_row({row, y}, racetrack) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(racetrack, fn {v, x}, m -> if v == ".", do: m, else: Map.put(m, {x, y}, v) end)
  end

  defp inspect(racetrack, p1, p2, max_x, max_y) do
    IO.binwrite("#{inspect(p1)} -> #{inspect(p2)}\n")

    for y <- 0..max_y do
      for x <- 0..max_x,
          do:
            IO.binwrite(
              case {x, y} do
                ^p1 -> ">"
                ^p2 -> "@"
                p -> if MapSet.member?(racetrack, p), do: "#", else: "."
              end
            )

      IO.binwrite("\n")
    end

    IO.binwrite("\n\n")
  end
end

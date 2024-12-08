defmodule AoC2024.Day06.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/6#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @empty "."
  @obstruction "#"

  @north {0, -1}
  @south {0, 1}
  @east {1, 0}
  @west {-1, 0}

  @turns %{
    @north => @east,
    @east => @south,
    @south => @west,
    @west => @north
  }

  def run(data) do
    data
    |> parse()
    |> add_obstructions()
    |> Enum.count(&loop?/1)
  end

  defp add_obstructions({lab, start}) do
    lab
    |> Enum.filter(fn {p, v} -> v == @empty && p != start end)
    |> Enum.map(fn {p, _} -> {Map.put(lab, p, @obstruction), start} end)
  end

  defp loop?({lab, start}) do
    {MapSet.new(), start, @north}
    |> move(lab)
  end

  defp move({visited, pos, dir}, lab) do
    with dest <- next(pos, dir) do
      case lab[dest] do
        @empty ->
          if MapSet.member?(visited, {dest, dir}),
            do: true,
            else: move({MapSet.put(visited, {dest, dir}), dest, dir}, lab)

        @obstruction ->
          move({visited, pos, @turns[dir]}, lab)

        nil ->
          false
      end
    end
  end

  defp next({x, y}, {xd, yd}), do: {x + xd, y + yd}

  defp parse(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce({Map.new(), nil}, &add_row/2)
  end

  defp add_row({row, y}, state) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(state, fn {v, x}, s -> add(s, {x, y}, v) end)
  end

  defp add({lab, start}, pos, value) do
    case value do
      "^" -> {Map.put(lab, pos, @empty), pos}
      _ -> {Map.put(lab, pos, value), start}
    end
  end
end

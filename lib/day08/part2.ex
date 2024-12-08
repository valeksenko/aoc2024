defmodule AoC2024.Day08.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/8#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day
  
  @empty "."

  def run(data) do
    data
    |> parse()
    |> to_antinodes()
    |> length()
  end

  defp to_antinodes(map) do
    map
    |> Enum.reject(&(elem(&1, 1) == @empty))
    |> Enum.reduce(Map.new(), &add_antena/2)
    |> Map.values()
    |> Enum.flat_map(&(add_antinodes(&1, map)))
    |> Enum.uniq()
  end

  defp add_antena({p, a}, antenas) do
    antenas
    |> Map.get_and_update(
      a,
      fn as ->
        {a, [p | (as || [])]}
      end
    )
    |> elem(1)
  end

  defp add_antinodes(antenas, map) do
    antenas
    |> permutations()
    |> Enum.flat_map(&(add_antinode_pairs(&1, map)))
  end

  defp add_antinode_pairs({pos1, pos2}, map) do
    antinode_pairs(pos1, pos2, map) ++ antinode_pairs(pos2, pos1, map)
  end

  defp antinode_pairs({x1, y1}, {x2, y2}, map) do
    {x1, y1}
    |> Stream.iterate(fn {x, y} -> {x + (x1 - x2), y + (y1 - y2)} end)
    |> Stream.take_while(&Map.has_key?(map, &1))
    |> Enum.to_list()
  end

  defp permutations(antenas) do
    antenas
    |> Enum.reduce(
      {[], []},
      fn antena, {pairs, processed} ->
        {pairs ++ Enum.zip_with([processed], &add_pair(&1, antena)), [antena | processed]}
      end
    )
    |> elem(0)
  end

  defp add_pair([a1], a2), do: {a1, a2}

  defp parse(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
  end
 
  defp add_row({row, y}, map) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(map, fn {v, x}, m -> Map.put(m, {x, y}, v) end)
  end
end

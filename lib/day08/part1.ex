defmodule AoC2024.Day08.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/8
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
    |> Enum.flat_map(&add_antinodes/1)
    |> Enum.uniq()
    |> Enum.filter(&Map.has_key?(map, &1))
  end

  defp add_antena({p, a}, antenas) do
    antenas
    |> Map.get_and_update(
      a,
      fn as ->
        {a, [p | as || []]}
      end
    )
    |> elem(1)
  end

  defp add_antinodes(antenas) do
    antenas
    |> permutations()
    |> Enum.flat_map(&add_antinode_pairs/1)
  end

  defp add_antinode_pairs({{x1, y1}, {x2, y2}}) do
    [
      {
        antinode_axis(x1, x2),
        antinode_axis(y1, y2)
      },
      {
        antinode_axis(x2, x1),
        antinode_axis(y2, y1)
      }
    ]
  end

  defp antinode_axis(n1, n2), do: n1 + (n1 - n2)

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

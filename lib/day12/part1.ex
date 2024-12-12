defmodule AoC2024.Day12.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/12
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @neighbors [
    {0, -1},
    {0, 1},
    {1, 0},
    {-1, 0}
  ]

  def run(data) do
    data
    |> parse()
    |> to_regions()
    |> Enum.map(&fence_cost/1)
    |> Enum.sum()
  end

  defp to_regions(map) do
    map
    |> Enum.group_by(&elem(&1, 1))
    |> Map.values()
    |> Enum.map(fn l -> Enum.map(l, &elem(&1, 0)) end)
    |> Enum.flat_map(&map_region([], &1))
  end

  defp map_region(region, []), do: region

  defp map_region(region, [pos | reminder]) do
    with {reg, r} <- add_to_region(MapSet.new([pos]), pos, reminder) do
      map_region([MapSet.to_list(reg) | region], r)
    end
  end

  defp add_to_region(region, pos, reminder) do
    case neighbors(pos, reminder) do
      [] ->
        {region, reminder}

      ns ->
        Enum.reduce(ns, {region, reminder}, fn n, {reg, r} ->
          add_to_region(MapSet.put(reg, n), n, List.delete(r, n))
        end)
    end
  end

  defp neighbors({x, y}, reminder) do
    @neighbors
    |> Enum.map(fn {xd, yd} -> {x + xd, y + yd} end)
    |> Enum.filter(&Enum.member?(reminder, &1))
  end

  defp fence_cost(region) do
    length(region) *
      (region
       |> Enum.map(&no_neighbors(&1, region))
       |> Enum.sum())
  end

  defp no_neighbors({x, y}, region) do
    @neighbors
    |> Enum.map(fn {xd, yd} -> {x + xd, y + yd} end)
    |> Enum.reject(&Enum.member?(region, &1))
    |> length()
  end

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

defmodule AoC2024.Day09.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/9#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @empty :empty

  def run(data) do
    data
    |> hd()
    |> to_disk_map()
    |> compact_files()
    |> checksum()
  end

  defp to_disk_map(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.map(fn {a, i} -> if rem(i, 2) == 0, do: {div(i, 2), a}, else: {@empty, a} end)
  end

  defp compact_files(map) do
    map
    |> compact(map |> Enum.map(&elem(&1, 0)) |> Enum.reject(&(&1 == @empty)) |> Enum.max())
  end

  defp compact(map, 0), do: map

  defp compact(map, id) do
    map
    |> Enum.split_while(&(elem(&1, 0) != id))
    |> move_block()
    |> compact(id - 1)
  end

  defp move_block({map, [{id, amount} | reminder]}) do
    case Enum.split_while(map, fn {i, a} -> i != @empty || a < amount end) do
      {_, []} ->
        map ++ [{id, amount}] ++ reminder

      {m, [{_, a} | r]} ->
        m ++ [{id, amount}, {@empty, a - amount}] ++ r ++ [{@empty, amount}] ++ reminder
    end
  end

  defp checksum(map) do
    map
    |> Enum.reduce({0, 0}, fn {id, amount}, {total, index} ->
      {total + file_checksum(id, index, amount), index + amount}
    end)
    |> elem(0)
  end

  defp file_checksum(@empty, _, _), do: 0

  defp file_checksum(id, start, amount) do
    start..(start + amount - 1)
    |> Enum.map(&(&1 * id))
    |> Enum.sum()
  end
end

defmodule AoC2024.Day09.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/9
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> hd()
    |> to_disk_map()
    |> compact()
    |> checksum()
  end

  defp to_disk_map(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.map(fn {a, i} -> if rem(i, 2) == 0, do: {div(i, 2), a}, else: {:empty, a} end)
  end

  defp compact(map) do
    case Enum.split_while(map, &(elem(&1, 0) != :empty)) do
      {files, []} -> files
      {files, [{:empty, _} | []]} -> files
      {files, reminder} -> move_block(files, reminder) |> compact()
    end
  end

  defp move_block(files, [{:empty, 0} | reminder]), do: files ++ reminder

  defp move_block(files, [{:empty, amount} | reminder]) do
    case List.pop_at(reminder, -1) do
      {{:empty, _}, r} ->
        files ++ [{:empty, amount}] ++ r

      {{id, a}, r} ->
        if a > amount,
          do: files ++ [{id, amount}] ++ r ++ [{id, a - amount}],
          else: files ++ [{id, a}, {:empty, amount - a}] ++ r
    end
  end

  defp checksum(files) do
    files
    |> Enum.reduce({0, 0}, fn {id, amount}, {total, index} ->
      {total + file_checksum(id, index, amount), index + amount}
    end)
    |> elem(0)
  end

  defp file_checksum(id, start, amount) do
    start..(start + amount - 1)
    |> Enum.map(&(&1 * id))
    |> Enum.sum()
  end
end

defmodule AoC2024.Day01.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/1
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> Enum.map(&to_tuples/1)
    |> to_lists()
    |> to_distances()
    |> Enum.sum()
  end

  defp to_tuples(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp to_lists(tuples) do
    tuples
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(&Enum.sort/1)
  end

  defp to_distances(lists) do
    lists
    |> Enum.zip()
    |> Enum.map(fn {e1, e2} -> abs(e1 - e2) end)
  end
end

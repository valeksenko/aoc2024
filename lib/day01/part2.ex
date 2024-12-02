defmodule AoC2024.Day01.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/1#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> Enum.map(&to_tuples/1)
    |> Enum.unzip()
    |> to_scores()
    |> Enum.sum()
  end

  defp to_tuples(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp to_scores({l1, l2}) do
    l1
    |> Enum.map(fn e -> e * Enum.count(l2, &(&1 == e)) end)
  end
end

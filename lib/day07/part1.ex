defmodule AoC2024.Day07.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/7
  """

  import AoC2024.Day07.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> Enum.map(&parse_equations/1)
    |> Enum.filter(&solvable/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp solvable({total, [n | numbers]}), do: solvable?(n, numbers, total)

  defp solvable?(acc, [], total), do: acc == total
  defp solvable?(acc, _, total) when acc > total, do: false

  defp solvable?(acc, [h | t], total),
    do: solvable?(acc + h, t, total) || solvable?(acc * h, t, total)
end

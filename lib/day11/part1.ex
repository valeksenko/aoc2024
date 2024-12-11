defmodule AoC2024.Day11.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/11
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @runs 25
  @multi 2024

  def run(data) do
    data
    |> hd()
    |> to_stones()
    |> blink(@runs)
    |> length()
  end

  defp blink(stones, runs) do
    stones
    |> Stream.iterate(&run_step/1)
    |> Stream.drop(runs)
    |> Enum.take(1)
    |> hd()
  end

  defp run_step(stones) do
    stones
    |> Enum.reverse()
    |> Enum.reduce([], fn s, c -> step(s, s |> Integer.digits(), c) end)
  end

  defp step(0, _, stones), do: [1 | stones]
  defp step(_, digits, stones) when rem(length(digits), 2) == 0, do: split(digits) ++ stones
  defp step(stone, _, stones), do: [stone * @multi | stones]

  defp split(digits),
    do:
      digits
      |> Enum.split(div(length(digits), 2))
      |> Tuple.to_list()
      |> Enum.map(&Integer.undigits/1)

  defp to_stones(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end

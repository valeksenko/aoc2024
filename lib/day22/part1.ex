defmodule AoC2024.Day22.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/22
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @steps 2000

  def run(data) do
    data
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&calc/1)
    |> Enum.sum()
  end

  defp calc(init) do
    init
    |> Stream.iterate(&next/1)
    |> Stream.drop(@steps)
    |> Enum.take(1)
    |> hd()
  end

  defp next(num) do
    [
      &(&1 * 64),
      &div(&1, 32),
      &(&1 * 2048)
    ]
    |> Enum.reduce(num, fn f, n -> f.(n) |> mix(n) |> prune() end)
  end

  defp mix(num1, num2), do: Bitwise.bxor(num1, num2)
  defp prune(num), do: rem(num, 16_777_216)
end

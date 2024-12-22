defmodule AoC2024.Day22.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/22#part22
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @steps 2000

  def run(data) do
    data
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&calc/1)
    |> find_max()
  end

  defp find_max(diffs) do
    diffs
    |> to_sequences()
    |> Enum.map(&calc_seq(&1, diffs))
    |> Enum.max()
  end

  defp calc_seq(seq, diffs) do
    diffs
    |> Enum.map(&find_seq(&1, seq, [], seq, 0))
    |> Enum.sum()
  end

  defp find_seq(_, [], _, _, n), do: n
  defp find_seq([], _, _, _, n), do: 0

  defp find_seq([{n, d} | diff], [d | seq], collected, orig, _),
    do: find_seq(diff, seq, [{n, d} | collected], orig, n)

  defp find_seq(diff, _, [], orig, _), do: find_seq(tl(diff), orig, [], orig, 0)

  defp find_seq(diff, _, collected, orig, _),
    do: find_seq((collected |> Enum.reverse() |> tl()) ++ diff, orig, [], orig, 0)

  defp to_sequences(diffs) do
    diffs
    |> Enum.map(fn d -> Enum.map(d, &elem(&1, 1)) end)
    |> Enum.flat_map(&Enum.chunk_every(&1, 4, 1, :discard))
    |> Enum.uniq()
  end

  defp calc(init) do
    init
    |> Stream.iterate(&next/1)
    |> Stream.take(@steps)
    |> Enum.to_list()
    |> Enum.map(&rem(&1, 10))
    |> to_diff()
  end

  defp to_diff(nums) do
    nums
    |> tl()
    |> Enum.zip(nums)
    |> Enum.map(fn {n1, n2} -> {n1, n1 - n2} end)
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

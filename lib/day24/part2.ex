defmodule AoC2024.Day24.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/24#part2
  """

  import AoC2024.Day24.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data, times \\ 4) do
    data
    |> parse_program()
    |> find_swapped(times)
    |> result()
  end

  defp find_swapped({wires, connections}, times) do
    connections
    |> combinations(times * 2)
    |> Enum.reject(&(uniq_gates(&1) != times * 4))
    |> Enum.find(&addition?(&1, wires, connections))
  end

  defp addition?(combo, wires, connections) do
    combo
    |> unique_pairs()
    |> Enum.any?(&swapped_addition?(&1, wires, connections))
  end

  defp swapped_addition?(pairs, wires, connections) do
    {
      wires,
      pairs
      |> Enum.reduce(connections, fn {{c1, g1}, {c2, g2}}, cons ->
        cons |> replace({c1, g1}, g2) |> replace({c2, g2}, g1)
      end)
    }
    |> process()
    |> match?()
  end

  defp match?(wires), do: int_value(wires, "x") + int_value(wires, "y") == int_value(wires, "z")

  defp int_value(wires, letter) do
    wires
    |> Enum.filter(&(elem(&1, 0) |> String.starts_with?(letter)))
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.map(&elem(&1, 1))
    |> Integer.undigits(2)
  end

  defp replace(connections, {c, g}, dest), do: [{c, dest} | List.delete(connections, {c, g})]

  # tailored for 2 or 4 members
  def unique_pairs([c1, c2]), do: [[{c1, c2}]]

  def unique_pairs(list) do
    with pairs <- Enum.reduce(list, [], fn x, acc -> acc ++ for y <- list, x < y, do: {x, y} end) do
      Enum.reduce(pairs, [], fn {a1, b1}, acc ->
        acc ++
          for {a2, b2} <- pairs,
              a1 != a2 and a1 != b2 and b1 != a2 and b1 != b2,
              a1 < a2,
              do: [{a1, b1}, {a2, b2}]
      end)
    end
  end

  defp process(initial) do
    initial
    |> Stream.iterate(&step/1)
    |> Stream.drop_while(&in_progress?/1)
    |> Enum.take(1)
    |> hd()
    |> elem(0)
  end

  defp step({wires, connections}) do
    connections
    |> Enum.reduce(
      {wires, []},
      fn {{op, g1, g2}, dest} = c, {w, conn} ->
        if w[g1] && w[g2],
          do: {Map.put(w, dest, op.(w[g1], w[g2])), conn},
          else: {w, [c | conn]}
      end
    )
  end

  defp uniq_gates(connections) do
    connections
    |> Enum.flat_map(fn {{_, g1, g2}, _} -> [g1, g2] end)
    |> Enum.uniq()
    |> length()
  end

  defp result(wires) do
    wires
    |> Map.keys()
    |> Enum.filter(&String.starts_with?(&1, "z"))
    |> Enum.sort()
    |> Enum.join(",")
  end

  defp in_progress?({_, connections}) do
    connections
    |> Enum.any?(fn {_, gate} -> String.starts_with?(gate, "z") end)
  end

  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []

  defp combinations([h | t], k) do
    (for(l <- combinations(t, k - 1), do: [h | l]) ++ combinations(t, k))
    |> Enum.uniq()
  end

  defp permutations([]), do: [[]]

  defp permutations(list) do
    Enum.reduce(list, [], fn elem, acc ->
      acc ++ for rest <- permutations(list -- [elem]), do: [elem | rest]
    end)
  end
end

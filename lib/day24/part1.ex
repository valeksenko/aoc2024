defmodule AoC2024.Day24.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/24
  """

  import AoC2024.Day24.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> parse_program()
    |> process()
    |> result()
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

  defp result(wires) do
    wires
    |> Enum.filter(&(elem(&1, 0) |> String.starts_with?("z")))
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.map(&elem(&1, 1))
    |> Integer.undigits(2)
  end

  defp in_progress?({_, connections}) do
    connections
    |> Enum.any?(fn {_, gate} -> String.starts_with?(gate, "z") end)
  end
end

defmodule AoC2024.Day23.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/23
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> Enum.map(&String.split(&1, "-"))
    |> inter_connected()
    |> Enum.sort()
    |> Enum.join(",")
  end

  defp inter_connected([conn | connections]) do
    connections
    |> Enum.reduce({[{conn, connections}], connections}, fn c, {acc, cs} ->
      {[{c, tl(cs)} | acc], tl(cs)}
    end)
    |> elem(0)
    |> Enum.drop(2)
    |> Enum.reverse()
    |> Enum.map(&find_connected/1)
    |> Enum.max_by(&length/1)
  end

  defp find_connected({[comp1, comp2], connections}) do
    connections
    # TODO: implement following the connections until no more left
    # |> Enum.reduce_while({[comp1], [comp1, comp2]}, )
  end

  defp connected?(conn1, conn2), do: Enum.any?(conn1, &Enum.member?(conn2, &1))
end

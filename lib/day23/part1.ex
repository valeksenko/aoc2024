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
    |> Enum.count(&Enum.any?(&1, fn n -> String.starts_with?(n, "t") end))
  end

  defp inter_connected([conn | connections]) do
    connections
    |> Enum.reduce({[{conn, connections}], connections}, fn c, {acc, cs} ->
      {[{c, tl(cs)} | acc], tl(cs)}
    end)
    |> elem(0)
    |> Enum.drop(2)
    |> Enum.reverse()
    |> Enum.flat_map(&find_connected/1)
    |> Enum.uniq()
  end

  defp find_connected({[comp1, comp2], connections}) do
    MapSet.intersection(
      connections |> Enum.filter(&Enum.member?(&1, comp1)) |> List.flatten() |> MapSet.new(),
      connections |> Enum.filter(&Enum.member?(&1, comp2)) |> List.flatten() |> MapSet.new()
    )
    |> Enum.map(&[comp1, comp2, &1])
  end
end

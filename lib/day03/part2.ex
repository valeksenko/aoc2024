defmodule AoC2024.Day03.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/3#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @enable "do()"
  @disable "don't()"

  def run(data) do
    data
    |> Enum.flat_map(&to_multis/1)
    |> Enum.reduce({[], true}, &run/2)
    |> elem(0)
    |> Enum.map(&multiply/1)
    |> Enum.sum()
  end

  defp to_multis(input) do
    ~r/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/
    |> Regex.scan(input)
    |> Enum.concat()
  end

  defp run(@enable, {multis, _}), do: {multis, true}
  defp run(@disable, {multis, _}), do: {multis, false}
  defp run(multi, {multis, true}), do: {[multi | multis], true}
  defp run(_, state), do: state

  defp multiply(multi) do
    ~r/\d+/
    |> Regex.scan(multi)
    |> Enum.concat()
    |> Enum.map(&String.to_integer/1)
    |> Enum.product()
  end
end

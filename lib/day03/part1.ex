defmodule AoC2024.Day03.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/3
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> Enum.flat_map(&to_multis/1)
    |> Enum.map(&multiply/1)
    |> Enum.sum()
  end

  defp to_multis(input) do
    ~r/mul\(\d{1,3},\d{1,3}\)/
    |> Regex.scan(input)
    |> Enum.concat()
  end

  defp multiply(multi) do
    ~r/\d+/
    |> Regex.scan(multi)
    |> Enum.concat()
    |> Enum.map(&String.to_integer/1)
    |> Enum.product()
  end
end

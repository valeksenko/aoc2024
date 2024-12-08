defmodule AoC2024.Day02.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @safe_range 1..3

  def run(data) do
    data
    |> Enum.map(&to_report/1)
    |> Enum.count(&safe_report?/1)
  end

  defp to_report(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  defp safe_report?(report) do
    report
    |> Enum.zip(tl(report))
    |> Enum.map(fn {e1, e2} -> e1 - e2 end)
    |> safe?()
  end

  defp safe?(diffs) do
    Enum.all?(diffs, &(abs(&1) in @safe_range)) && monotonous?(diffs)
  end

  defp monotonous?([h | t]) do
    sign = h / abs(h)
    Enum.all?(t, fn e -> e / abs(e) == sign end)
  end
end

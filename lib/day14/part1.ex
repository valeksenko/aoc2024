defmodule AoC2024.Day14.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/14
  """

  import AoC2024.Day14.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @seconds 100

  def run(data, width \\ 101, height \\ 103) do
    data
    |> Enum.map(&parse_robot/1)
    |> progress(@seconds, width, height)
    |> result(width, height)
  end

  defp progress(robots, seconds, width, height) do
    robots
    |> Stream.iterate(&move_all(&1, width, height))
    |> Stream.drop(seconds)
    |> Enum.take(1)
    |> hd()
  end

  defp move_all(robots, width, height) do
    robots
    |> Enum.map(&move(&1, width, height))
  end

  defp move({{x, y}, {xd, yd}}, width, height),
    do: {{next(x + xd, width), next(y + yd, height)}, {xd, yd}}

  defp next(n, limit) when n < 0, do: limit + n
  defp next(n, limit), do: rem(n, limit)

  defp result(robots, width, height) do
    robots
    |> Enum.reduce({0, 0, 0, 0}, &categorize(&1, &2, div(width, 2), div(height, 2)))
    |> Tuple.product()
  end

  defp categorize({{x, y}, _}, {c1, c2, c3, c4}, limit_x, limit_y) do
    cond do
      x < limit_x && y < limit_y -> {c1 + 1, c2, c3, c4}
      x < limit_x && y > limit_y -> {c1, c2 + 1, c3, c4}
      x > limit_x && y < limit_y -> {c1, c2, c3 + 1, c4}
      x > limit_x && y > limit_y -> {c1, c2, c3, c4 + 1}
      true -> {c1, c2, c3, c4}
    end
  end
end

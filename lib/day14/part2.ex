defmodule AoC2024.Day14.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/14#part2
  """

  import AoC2024.Day14.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data, width \\ 101, height \\ 103) do
    data
    |> Enum.map(&parse_robot/1)
    |> progress(width, height)
  end

  defp progress(robots, width, height) do
    robots
    |> Stream.iterate(&move_all(&1, width, height))
    |> Stream.with_index()
    |> Stream.drop_while(&check(&1, width, height))
    |> Enum.take(1)
  end

  defp move_all(robots, width, height) do
    robots
    |> Enum.map(&move(&1, width, height))
  end

  defp move({{x, y}, {xd, yd}}, width, height),
    do: {{next(x + xd, width), next(y + yd, height)}, {xd, yd}}

  defp next(n, limit) when n < 0, do: limit + n
  defp next(n, limit), do: rem(n, limit)

  defp check({robots, ind}, width, height) do
    positions = Enum.map(robots, &elem(&1, 0))

    if Enum.count(positions, fn {x, _} -> x == 0 || x == width - 1 end) > 4,
      do: true,
      else: show(positions, ind, width, height)
  end

  defp show(positions, ind, width, height) do
    for y <- 0..(height - 1) do
      for x <- 0..(width - 1),
          do: IO.binwrite(if Enum.member?(positions, {x, y}), do: "#", else: " ")

      IO.binwrite("\n")
    end

    IO.binwrite("\nIndex: #{ind}\n")

    :timer.sleep(400)

    true
  end
end

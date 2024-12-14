defmodule AoC2024.Day13.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/13
  """

  import AoC2024.Day13.Parser

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @cost [3, 1]

  @max_pushes 100

  def run(data) do
    data
    |> parse_rules()
    |> Enum.map(&count_pushes/1)
    |> Enum.sum()
  end

  defp count_pushes({buttons, prize}) do
    goal = fn {pos, _, _} -> pos == prize end
    push_cost = fn _, {_, cost, _} -> cost end
    # we can't estimate, so using it as a Dijkstra's
    estimated_cost = fn _, _ -> 1 end

    push = fn {pos, _, pushes} ->
      if max_pushes?(pushes) || missed_target?(pos, prize),
        do: [],
        else:
          @cost
          |> Enum.zip(buttons)
          |> Enum.with_index()
          |> Enum.map(&next(&1, pos, pushes))
    end

    Astar.astar({push, push_cost, estimated_cost}, {{0, 0}, 0, %{0 => 0, 1 => 0}}, goal)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp next({{c, {xd, yd}}, i}, {x, y}, pushes),
    do: {{x + xd, y + yd}, c, Map.update!(pushes, i, &(&1 + 1))}

  defp max_pushes?(pushes), do: pushes |> Map.values() |> Enum.any?(&(&1 > @max_pushes))

  defp missed_target?({x, y}, {tx, ty}), do: x > tx || y > ty
end

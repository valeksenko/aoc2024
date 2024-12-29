defmodule AoC2024.Day25.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/25
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @pin_width 5
  @pin_size 7

  @pin "#"

  def run(data) do
    data
    |> to_schematics()
    |> Enum.reduce({[], []}, &from_schematics/2)
    |> count_matches()
  end

  defp count_matches({locks, keys}) do
    locks
    |> Enum.map(&matches(&1, keys))
    |> Enum.sum()
  end

  defp matches(lock, keys), do: Enum.count(keys, &matching?(&1, lock))

  defp matching?(key, lock) do
    key
    |> Enum.zip(lock)
    |> Enum.all?(&(Tuple.sum(&1) <= @pin_size))
  end

  defp to_schematics(data) do
    data
    |> Enum.map(&String.graphemes/1)
    |> Enum.chunk_every(@pin_size)
  end

  defp from_schematics(schematics, {locks, keys}) do
    if Enum.any?(hd(schematics), &(&1 == @pin)),
      do: {[to_pins(schematics) | locks], keys},
      else: {locks, [to_pins(Enum.reverse(schematics)) | keys]}
  end

  defp to_pins(schematics) do
    schematics
    |> Enum.reduce(List.duplicate(0, @pin_width), &add_row/2)
  end

  defp add_row(row, pins) do
    row
    |> Enum.with_index()
    |> Enum.reduce(pins, fn {e, i}, p ->
      if e == @pin, do: List.update_at(p, i, &(&1 + 1)), else: p
    end)
  end
end

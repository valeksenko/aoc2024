defmodule AoC2024.Day17.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/17
  """

  import AoC2024.Day17.Parser
  import AoC2024.Day17.BootCode
  alias AoC2024.Day17.BootCode

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> parse_program()
    |> exec()
    |> result()
  end

  defp exec({registers, code}) do
    {:ok, %BootCode{registers: registers, code: code}}
    |> Stream.iterate(fn {_, prog} -> step(prog) end)
    |> Stream.drop_while(&(elem(&1, 0) == :ok))
    |> Enum.take(1)
    |> hd()
    |> elem(1)
  end

  defp result(prog), do: prog.out |> Enum.reverse() |> Enum.join(",")
end

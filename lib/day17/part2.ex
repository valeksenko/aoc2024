defmodule AoC2024.Day17.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/17#part2
  """

  import AoC2024.Day17.Parser
  import AoC2024.Day17.BootCode
  alias AoC2024.Day17.BootCode

  @behaviour AoC2024.Day

  @impl AoC2024.Day

  def run(data) do
    data
    |> parse_program()
    |> detect()
  end

  defp detect({registers, code}) do
    {0, []}
    |> Stream.iterate(&exec(elem(&1, 0), registers, code))
    |> Stream.drop_while(fn {_, out} -> out != code end)
    |> Enum.take(1)
    |> hd()
    |> elem(0)
    |> Kernel.-(1)
  end

  defp exec(ind, registers, code) do
    {:ok, %BootCode{registers: registers |> Map.put("A", ind), code: code}}
    |> Stream.iterate(fn {_, prog} -> step(prog) end)
    |> Stream.drop_while(&keep_going?/1)
    |> Enum.take(1)
    |> hd()
    |> (fn {_, p} -> {ind + 1, Enum.reverse(p.out)} end).()
  end

  defp keep_going?({:ok, prog}),
    do: prog.out |> Enum.reverse() |> Enum.zip(prog.code) |> Enum.all?(fn {o, c} -> o == c end)

  defp keep_going?({:halt, _}), do: false
end

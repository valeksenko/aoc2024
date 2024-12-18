defmodule AoC2024.Day17.BootCode do
  @moduledoc false

  defstruct registers: %{}, code: [], out: [], position: 0

  @instructions %{
    0 => :adv,
    1 => :bxl,
    2 => :bst,
    3 => :jnz,
    4 => :bxc,
    5 => :out,
    6 => :bdv,
    7 => :cdv
  }

  @reg_a "A"
  @reg_b "B"
  @reg_c "C"

  def step(prog) do
    prog |> next |> exec_next(prog)
  end

  def next(prog) do
    Enum.fetch(prog.code, prog.position)
  end

  def exec_next({:ok, op}, prog) do
    {:ok, exec_op(@instructions[op], Enum.at(prog.code, prog.position + 1), prog)}
  end

  def exec_next(:error, prog) do
    {:halt, prog}
  end

  def exec_op(:adv, arg, prog) do
    %{
      prog
      | position: prog.position + 2,
        registers: Map.update!(prog.registers, @reg_a, &div(&1, 2 ** combo(arg, prog)))
    }
  end

  def exec_op(:bxl, arg, prog) do
    %{
      prog
      | position: prog.position + 2,
        registers: Map.update!(prog.registers, @reg_b, &Bitwise.bxor(&1, arg))
    }
  end

  def exec_op(:bst, arg, prog) do
    %{
      prog
      | position: prog.position + 2,
        registers: Map.put(prog.registers, @reg_b, rem(combo(arg, prog), 8))
    }
  end

  def exec_op(:jnz, arg, prog) do
    if prog.registers[@reg_a] == 0,
      do: %{prog | position: prog.position + 2},
      else: %{prog | position: arg}
  end

  def exec_op(:bxc, _, prog) do
    %{
      prog
      | position: prog.position + 2,
        registers: Map.update!(prog.registers, @reg_b, &Bitwise.bxor(&1, prog.registers[@reg_c]))
    }
  end

  def exec_op(:out, arg, prog) do
    %{prog | position: prog.position + 2, out: [rem(combo(arg, prog), 8) | prog.out]}
  end

  def exec_op(:bdv, arg, prog) do
    %{
      prog
      | position: prog.position + 2,
        registers:
          Map.put(prog.registers, @reg_b, div(prog.registers[@reg_a], 2 ** combo(arg, prog)))
    }
  end

  def exec_op(:cdv, arg, prog) do
    %{
      prog
      | position: prog.position + 2,
        registers:
          Map.put(prog.registers, @reg_c, div(prog.registers[@reg_a], 2 ** combo(arg, prog)))
    }
  end

  def combo(arg, _) when arg in 0..3, do: arg
  def combo(4, prog), do: Map.get(prog.registers, @reg_a)
  def combo(5, prog), do: Map.get(prog.registers, @reg_b)
  def combo(6, prog), do: Map.get(prog.registers, @reg_c)
end

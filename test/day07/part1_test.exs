defmodule AoC2024.Day07.Part1Test do
  use ExUnit.Case
  doctest AoC2024.Day07.Part1
  import AoC2024.Day07.Part1
  import TestHelper

  test "runs for sample input" do
    assert 3749 == run(read_example(:day07))
  end
end

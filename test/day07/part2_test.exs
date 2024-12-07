defmodule AoC2024.Day07.Part2Test do
  use ExUnit.Case
  doctest AoC2024.Day07.Part2
  import AoC2024.Day07.Part2
  import TestHelper

  test "runs for sample input" do
    assert 11387 == run(read_example(:day07))
  end
end

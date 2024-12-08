defmodule AoC2024.Day08.Part2Test do
  use ExUnit.Case
  doctest AoC2024.Day08.Part2
  import AoC2024.Day08.Part2
  import TestHelper

  test "runs for sample input" do
    assert 34 == run(read_example(:day08))
  end
end

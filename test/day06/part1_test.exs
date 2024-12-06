defmodule AoC2024.Day06.Part1Test do
  use ExUnit.Case
  doctest AoC2024.Day06.Part1
  import AoC2024.Day06.Part1
  import TestHelper

  test "runs for sample input" do
    assert 41 == run(read_example(:day06))
  end
end

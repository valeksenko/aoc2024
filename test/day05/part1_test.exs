defmodule AoC2024.Day05.Part1Test do
  use ExUnit.Case
  doctest AoC2024.Day05.Part1
  import AoC2024.Day05.Part1
  import TestHelper

  test "runs for sample input" do
    assert 143 == run(read_example_file(:day05))
  end
end

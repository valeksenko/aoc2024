defmodule AoC2024.Day02.Part2Test do
  use ExUnit.Case
  doctest AoC2024.Day02.Part2
  import AoC2024.Day02.Part2
  import TestHelper

  test "runs for sample input" do
    assert 4 == run(read_example(:day02))
  end
end
defmodule AoC2024.Day15.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day15.Part1
  import AoC2024.Day15.Part1
  import TestHelper

  test "runs for sample input" do
    assert 10_092 == run(read_example(:day15, false))
  end
end

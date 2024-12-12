defmodule AoC2024.Day12.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day12.Part1
  import AoC2024.Day12.Part1
  import TestHelper

  test "runs for sample input" do
    assert 1930 == run(read_example(:day12))
  end
end

defmodule AoC2024.Day12.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day12.Part2
  import AoC2024.Day12.Part2
  import TestHelper

  test "runs for sample input" do
    assert 1206 == run(read_example(:day12))
  end
end

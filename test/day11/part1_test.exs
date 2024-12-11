defmodule AoC2024.Day11.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day11.Part1
  import AoC2024.Day11.Part1
  import TestHelper

  test "runs for sample input" do
    assert 55_312 == run(read_example(:day11))
  end
end

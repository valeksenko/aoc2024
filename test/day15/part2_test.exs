defmodule AoC2024.Day15.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day15.Part2
  import AoC2024.Day15.Part2
  import TestHelper

  test "runs for sample input" do
    assert 9_021 == run(read_example(:day15, false))
  end
end

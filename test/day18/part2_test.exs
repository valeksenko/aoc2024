defmodule AoC2024.Day18.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day18.Part2
  import AoC2024.Day18.Part2
  import TestHelper

  test "runs for sample input" do
    assert {6, 1} == run(read_example(:day18), 6)
  end
end

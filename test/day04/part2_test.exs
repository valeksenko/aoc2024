defmodule AoC2024.Day04.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day04.Part2
  import AoC2024.Day04.Part2
  import TestHelper

  test "runs for sample input" do
    assert 9 == run(read_example(:day04))
  end
end

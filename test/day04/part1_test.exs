defmodule AoC2024.Day04.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day04.Part1
  import AoC2024.Day04.Part1
  import TestHelper

  test "runs for sample input" do
    assert 18 == run(read_example(:day04))
  end
end

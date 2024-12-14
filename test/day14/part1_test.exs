defmodule AoC2024.Day14.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day14.Part1
  import AoC2024.Day14.Part1
  import TestHelper

  test "runs for sample input" do
    assert 12 == run(read_example(:day14), 11, 7)
  end
end

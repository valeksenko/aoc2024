defmodule AoC2024.Day18.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day18.Part1
  import AoC2024.Day18.Part1
  import TestHelper

  test "runs for sample input" do
    assert 22 == run(read_example(:day18), 6, 12)
  end
end

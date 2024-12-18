defmodule AoC2024.Day17.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day17.Part2
  import AoC2024.Day17.Part2
  import TestHelper

  test "runs for sample input" do
    assert 117_440 == run(read_example_file(:day17_1))
  end
end

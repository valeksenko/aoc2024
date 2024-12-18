defmodule AoC2024.Day17.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day17.Part1
  import AoC2024.Day17.Part1
  import TestHelper

  test "runs for sample input" do
    assert "4,6,3,5,6,3,5,2,1,0" == run(read_example_file(:day17))
  end
end

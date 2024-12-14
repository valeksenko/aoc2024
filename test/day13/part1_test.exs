defmodule AoC2024.Day13.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day13.Part1
  import AoC2024.Day13.Part1
  import TestHelper

  test "runs for sample input" do
    assert 480 == run(read_example_file(:day13))
  end
end

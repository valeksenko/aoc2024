defmodule AoC2024.Day24.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day24.Part1
  import AoC2024.Day24.Part1
  import TestHelper

  test "runs for sample input" do
    assert 2024 == run(read_example_file(:day24))
  end
end

defmodule AoC2024.Day19.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day19.Part1
  import AoC2024.Day19.Part1
  import TestHelper

  test "runs for sample input" do
    assert 6 == run(read_example(:day19))
  end
end

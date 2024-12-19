defmodule AoC2024.Day19.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day19.Part2
  import AoC2024.Day19.Part2
  import TestHelper

  test "runs for sample input" do
    assert 16 == run(read_example(:day19))
  end
end

defmodule AoC2024.Day03.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day03.Part2
  import AoC2024.Day03.Part2
  import TestHelper

  test "runs for sample input" do
    assert 48 == run(read_example(:day03_1))
  end
end

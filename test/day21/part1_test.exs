defmodule AoC2024.Day21.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day21.Part1
  import AoC2024.Day21.Part1
  import TestHelper

  test "runs for sample input" do
    assert 126_384 == run(read_example(:day21))
  end
end

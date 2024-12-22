defmodule AoC2024.Day22.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day22.Part2
  import AoC2024.Day22.Part2
  import TestHelper

  test "runs for sample input" do
    assert 23 == run(read_example(:day22_1))
  end
end

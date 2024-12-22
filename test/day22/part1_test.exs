defmodule AoC2024.Day22.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day22.Part1
  import AoC2024.Day22.Part1
  import TestHelper

  test "runs for sample input" do
    assert 37_327_623 == run(read_example(:day22))
  end
end

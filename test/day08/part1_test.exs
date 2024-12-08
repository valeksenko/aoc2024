defmodule AoC2024.Day08.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day08.Part1
  import AoC2024.Day08.Part1
  import TestHelper

  test "runs for sample input" do
    assert 14 == run(read_example(:day08))
  end
end

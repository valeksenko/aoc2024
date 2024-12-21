defmodule AoC2024.Day20.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day20.Part1
  import AoC2024.Day20.Part1
  import TestHelper

  test "runs for sample input" do
    assert 10 == run(read_example(:day20), 10)
  end
end

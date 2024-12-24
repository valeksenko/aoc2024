defmodule AoC2024.Day23.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day23.Part1
  import AoC2024.Day23.Part1
  import TestHelper

  test "runs for sample input" do
    assert 7 == run(read_example(:day23))
  end
end

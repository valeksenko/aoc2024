defmodule AoC2024.Day25.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day25.Part1
  import AoC2024.Day25.Part1
  import TestHelper

  test "runs for sample input" do
    assert 3 == run(read_example(:day25))
  end
end

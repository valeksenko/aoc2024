defmodule AoC2024.Day01.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day01.Part2
  import AoC2024.Day01.Part2
  import TestHelper

  test "runs for sample input" do
    assert 31 == run(read_example(:day01))
  end
end

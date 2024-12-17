defmodule AoC2024.Day16.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day16.Part2
  import AoC2024.Day16.Part2
  import TestHelper

  test "runs for sample input" do
    assert 45 == run(read_example(:day16))
    assert 64 == run(read_example(:day16_1))
  end
end

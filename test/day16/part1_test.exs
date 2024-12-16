defmodule AoC2024.Day16.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day16.Part1
  import AoC2024.Day16.Part1
  import TestHelper

  test "runs for sample input" do
    assert 7_036 == run(read_example(:day16))
    assert 11_048 == run(read_example(:day16_1))
  end
end

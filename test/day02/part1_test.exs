defmodule AoC2024.Day02.Part1Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day02.Part1
  import AoC2024.Day02.Part1
  import TestHelper

  test "runs for sample input" do
    assert 2 == run(read_example(:day02))
  end
end

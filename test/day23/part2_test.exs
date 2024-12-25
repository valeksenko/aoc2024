defmodule AoC2024.Day23.Part2Test do
  @moduledoc false
  use ExUnit.Case
  doctest AoC2024.Day23.Part2
  import AoC2024.Day23.Part2
  import TestHelper

  test "runs for sample input" do
    assert "co,de,ka,ta" == run(read_example(:day23))
  end
end

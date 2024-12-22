defmodule AoC2024.Day21.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/21
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @numeric :numeric
  @nstart {2, 4}
  @numeric_keypad %{
    {0, 0} => "7",
    {1, 0} => "8",
    {2, 0} => "9",
    {0, 1} => "4",
    {1, 1} => "5",
    {2, 1} => "6",
    {0, 3} => "1",
    {1, 3} => "2",
    {2, 3} => "3",
    {1, 4} => "0",
    {2, 4} => "A",
  }


  @directional :directional
  @dstart {2, 0}
  @directional_keypad %{
    {1, 0} => {0, -1},
    {2, 0} => :activate,
    {0, 1} => {-1, 0},
    {1, 1} => {0, 1},
    {2, 1} => {1, 0},
  }

  def run(data) do
    data
    |> Enum.map(&String.graphemes/1)
    |> to_sequences()
    |> Enum.map(fn {seq, code} -> length(seq) * to_int(code) end)
    |> Enum.sum()
  end

  defp to_sequences(codes) do
    codes
    |> Enum.map(&to_sequence/1)
    |> Enum.zip(codes)
  end

  defp to_sequence(codes) do
    codes
    |> Enum.reduce(
      {
        [
          {@directional, @dstart, @directional_keypad},
          {@directional, @dstart, @directional_keypad},
          {@directional, @dstart, @directional_keypad},
          {@numeric, @nstart, @numeric_keypad},
        ],
        []
      },
      &find_path/2
    )
    |> elem(1)
  end

  defp find_path(code, state) do
    {
      [],
      [1, 2]
    }
  end


  defp to_int(code) do
    code
    |> Enum.join()
    |> String.replace(~r{\D}, "")
    |> String.to_integer()
  end
end

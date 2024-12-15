defmodule AoC2024.Day15.Part1 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/15
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @wall "#"
  @box "O"

  @directions %{
    "^" => {0, -1},
    "v" => {0, 1},
    "<" => {-1, 0},
    ">" => {1, 0}
  }

  def run(data) do
    data
    |> parse()
    |> follow_directions()
    |> coordinates()
    |> Enum.sum()
  end

  defp follow_directions({robot, warehouse, movements}) do
    movements
    |> Enum.reduce({robot, warehouse}, &move(@directions[&1], &2))
    |> elem(1)
  end

  defp move({xd, yd}, {{x, y}, warehouse}) do
    with next <- {x + xd, y + yd} do
      case Map.get(warehouse, next) do
        nil ->
          {next, warehouse}

        @wall ->
          {{x, y}, warehouse}

        @box ->
          move_box(next, {xd, yd}, warehouse)
          |> (fn {moved, w} ->
                if moved, do: {next, Map.delete(w, next)}, else: {{x, y}, warehouse}
              end).()
      end
    end
  end

  defp move_box({x, y}, {xd, yd}, warehouse) do
    with next <- {x + xd, y + yd} do
      case Map.get(warehouse, next) do
        nil -> {true, warehouse |> Map.put(next, @box)}
        @wall -> {false, warehouse}
        @box -> move_box(next, {xd, yd}, warehouse)
      end
    end
  end

  defp coordinates(warehouse) do
    warehouse
    |> Enum.filter(&(elem(&1, 1) == @box))
    |> Enum.map(fn {{x, y}, _} -> x + y * 100 end)
  end

  defp parse(data) do
    data
    |> Enum.split_while(&(&1 != ""))
    |> (fn {d1, d2} -> to_warehouse(d1) |> Tuple.append(to_movements(tl(d2))) end).()
  end

  defp to_movements(data) do
    data
    |> Enum.join()
    |> String.graphemes()
  end

  defp to_warehouse(data) do
    data
    |> Enum.with_index()
    |> Enum.reduce(Map.new(), &add_row/2)
    |> find_robot()
  end

  defp find_robot(warehouse) do
    with {pos, _} <- Enum.find(warehouse, fn {_, v} -> v == "@" end) do
      {pos, Map.delete(warehouse, pos)}
    end
  end

  defp add_row({row, y}, warehouse) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(warehouse, fn {v, x}, w -> if v == ".", do: w, else: Map.put(w, {x, y}, v) end)
  end

  # defp inspect_warehouse(warehouse) do
  #   for y <- 0..(warehouse |> Enum.map(fn {{yp, _}, _} -> yp end) |> Enum.max()) do
  #     for x <- 0..(warehouse |> Enum.map(fn {{xp, _}, _} -> xp end) |> Enum.max()),
  #         do: IO.binwrite(Map.get(warehouse, {x, y}, " "))

  #     IO.binwrite("\n")
  #   end

  #   IO.binwrite("\n\n")

  #   warehouse
  # end
end

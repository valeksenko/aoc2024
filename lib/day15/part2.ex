defmodule AoC2024.Day15.Part2 do
  @moduledoc """
    @see https://adventofcode.com/2024/day/15#part2
  """
  @behaviour AoC2024.Day

  @impl AoC2024.Day

  @wall "#"

  @box "O"
  @part1 1
  @part2 -1

  @up {0, -1}
  @down {0, 1}
  @left {-1, 0}
  @right {1, 0}

  @directions %{
    "^" => @up,
    "v" => @down,
    "<" => @left,
    ">" => @right
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
    |> Enum.reduce({robot |> IO.inspect(label: "robot"), warehouse}, &move(@directions[&1], &2))
    |> elem(1)
  end

  defp move({xd, yd}, {{x, y}, warehouse}) do
    with next <- {x + xd, y + yd} do
      case Map.get(warehouse, next) do
        nil ->
          {next, warehouse}

        @wall ->
          {{x, y}, warehouse}

        part ->
          move_box(next, part, {xd, yd}, warehouse)
          |> (fn {moved, w} ->
                if moved, do: {next, w}, else: {{x, y}, warehouse}
              end).()
      end
    end
    |> inspect_warehouse
  end

  defp move_box({x, y}, part, {xd, yd}, warehouse) do
    IO.inspect({{x, y}, part, {xd, yd}}, label: "move_box")
    with next1 <- {x + xd, y + yd}, next2 <- {x + xd + part, y + yd} do
      case {{xd, yd}, part, Map.get(warehouse, next1), Map.get(warehouse, next2)} |> IO.inspect do
        {@left, _, _, nil} -> {true, warehouse |> Map.delete({x, y}) |> Map.put(next1, @part2) |> Map.put(next2, @part1)}
        {@left, _, _, @wall} -> {false, warehouse}
        {@left, _, _, _} -> move_box(next2, @part2, {xd, yd}, warehouse) |> (fn {r, w} -> {r, w |> Map.delete({x, y}) |> Map.put(next1, @part2) |> Map.put(next2, @part1)} end).()

        {@right, _, _, nil} -> {true, warehouse |> Map.delete({x, y}) |> Map.put(next1, @part1) |> Map.put(next2, @part2)}
        {@right, _, _, @wall} -> {false, warehouse}
        {@right, _, _, _} -> move_box(next2, @part1, {xd, yd}, warehouse) |> (fn {r, w} -> {r, w |> Map.delete({x, y}) |> Map.put(next1, @part1) |> Map.put(next2, @part2)} end).()

        # up & down
        {_, _, nil, nil} -> {true, warehouse |> Map.delete({x, y}) |> Map.delete({x + part, y}) |> Map.put(next1, part) |> Map.put(next2, -part)}

        {_, _, @wall, _} -> {false, warehouse}
        {_, _, _, @wall} -> {false, warehouse}

         # 1:1 box stack
        {_, p, p, _} -> move_box(next1, p, {xd, yd}, warehouse) |> (fn {r, w} -> {r, w |> Map.delete({x, y}) |> Map.delete({x + part, y}) |> Map.put(next1, part) |> Map.put(next2, -part)} end).()

        # 1:1 box stack shifted
        {_, _, nil, _} -> move_box(next2, part, {xd, yd}, warehouse) |> (fn {r, w} -> {r, w |> Map.delete({x + part + part, y}) |> Map.delete({x + part, y}) |> Map.put(next1, part) |> Map.put(next2, -part)} end).()
        {_, _, _, nil} -> move_box(next1, part, {xd, yd}, warehouse) |> (fn {r, w} -> {r, w |> Map.delete({x + part + part, y}) |> Map.delete({x + part, y}) |> Map.put(next1, part) |> Map.put(next2, -part)} end).()

        # 2:1 box stack
        #{_, _, _, _} ->  move_boxes(next1, next2, {xd, yd}, warehouse)
      end
    end
  end

  # defp move_boxes(next1, next2, dir, warehouse) do
  #   case move_box(next1, @part2, dir, warehouse) |> (fn {r, w} -> {r, w |> Map.delete({x, y}) |> Map.delete({x + @part2, y}) |> Map.put(next1, part) |> Map.put(next2, @part1)} end).() do
  #     {false, _} -> {false, warehouse}
  #     {true, w} -> move_box(next2, @part1, dir, w)|> (fn {r, w} -> {r, w |> Map.delete({x, y}) |> Map.delete({x + part, y}) |> Map.put(next1, part) |> Map.put(next2, -part)} end).()
  #   end
  # end

  defp coordinates(warehouse) do
    warehouse
    |> Enum.filter(&(elem(&1, 1) == @part1))
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
    |> Enum.reduce(warehouse, &add_value(&1, &2, y))
  end

  defp add_value({v, x}, warehouse, y) do
    case v do
      @wall -> warehouse |> Map.put({x * 2, y}, @wall) |> Map.put({x * 2 + 1, y}, @wall)
      @box -> warehouse |> Map.put({x * 2, y}, @part1) |> Map.put({x * 2 + 1, y}, @part2)
      "@" -> warehouse |> Map.put({x * 2, y}, "@")
      _ -> warehouse
    end
  end

  defp inspect_warehouse({robot, warehouse}) do
    for y <- 0..(warehouse |> Enum.map(fn {{_, yp}, _} -> yp end) |> Enum.max()) do
      for x <- 0..(warehouse |> Enum.map(fn {{xp, _}, _} -> xp end) |> Enum.max()),
          do: IO.binwrite(
            case Map.get(warehouse |> Map.put(robot, "@"), {x, y}, ".") do
              @part1 -> "["
              @part2 -> "]"
              v -> v
            end
          )


      IO.binwrite("\n")
    end

    IO.binwrite("\n\n")

    {robot, warehouse}
  end
end

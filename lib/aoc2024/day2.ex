defmodule Aoc2024.Day2 do
  @moduledoc """
  https://adventofcode.com/2024/day/2
  """

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn num -> Enum.map(num, &String.to_integer/1) end)
  end

  # 257
  def first(input \\ File.read!("priv/day2.txt")) do
    safe? = fn line ->
      monotone? = Enum.sort(line, :asc) == line or Enum.sort(line, :desc) == line

      small_jumps? =
        line
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.map(fn [x, y] ->
          delta = abs(x - y)

          delta >= 1 and delta <= 3
        end)
        |> Enum.all?()

      monotone? and small_jumps?
    end

    input
    |> parse()
    |> Enum.map(safe?)
    |> Enum.count(& &1)
  end

  # 328
  def second(input \\ File.read!("priv/day2.txt")) do
    safe? = fn line ->
      monotone? = Enum.sort(line, :asc) == line or Enum.sort(line, :desc) == line

      small_jumps? =
        line
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.map(fn [x, y] ->
          delta = abs(x - y)

          delta >= 1 and delta <= 3
        end)
        |> Enum.all?()

      monotone? and small_jumps?
    end

    input
    |> parse()
    |> Enum.map(fn line ->
      len = Enum.count(line)

      dampened_lines = Enum.map(0..(len - 1), fn i -> List.delete_at(line, i) end)

      Enum.any?([line | dampened_lines], &safe?.(&1))
    end)
    |> Enum.count(& &1)
  end

  def example_input do
    """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """
  end
end

defmodule Aoc2024.Day4 do
  @moduledoc """
  https://adventofcode.com/2024/day/4
  """

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
  end

  # 2560
  def first(input \\ File.read!("priv/day4.txt")) do
    grid = parse(input)

    deltas = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

    grid
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.map(fn {row, i} ->
      Enum.map(row, fn {cell, j} ->
        Enum.count(deltas, fn {a, b} ->
          cell == "X" and
            at(at(grid, i + a, []), j + b, nil) == "M" and
            at(at(grid, i + 2 * a, []), j + 2 * b, nil) == "A" and
            at(at(grid, i + 3 * a, []), j + 3 * b, nil) == "S"
        end)
      end)
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end

  defp at(list, index, default) do
    if index < 0, do: default, else: Enum.at(list, index, default)
  end

  # 1910
  def second(input \\ File.read!("priv/day4.txt")) do
    grid = parse(input)

    grid
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.map(fn {row, i} ->
      Enum.count(row, fn {cell, j} ->
        list_1 = [at(at(grid, i + 1, []), j + 1, nil), at(at(grid, i - 1, []), j - 1, nil)]
        list_2 = [at(at(grid, i + 1, []), j - 1, nil), at(at(grid, i - 1, []), j + 1, nil)]

        cell == "A" and "M" in list_1 and "S" in list_1 and "M" in list_2 and "S" in list_2
      end)
    end)
    |> Enum.sum()
  end

  def example_input do
    """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """
  end
end

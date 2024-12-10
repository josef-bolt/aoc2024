defmodule Aoc2024.Day1 do
  @moduledoc """
  https://adventofcode.com/2024/day/1
  """

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn num -> Enum.map(num, &String.to_integer/1) end)
  end

  # 2086478
  def first(input \\ File.read!("priv/day1.txt")) do
    input
    |> parse()
    |> Enum.zip_with(& &1)
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip_with(& &1)
    |> Enum.map(fn [x, y] -> abs(x - y) end)
    |> Enum.sum()
    |> dbg()
  end

  # 24941624
  def second(input \\ File.read!("priv/day1.txt")) do
    [first_list, second_list] =
      input
      |> parse()
      |> Enum.zip_with(& &1)

    frequencies = Enum.frequencies(second_list)

    first_list
    |> Enum.map(fn num -> {num, Map.get(frequencies, num, 0)} end)
    |> Enum.map(fn {num, freq} -> num * freq end)
    |> Enum.sum()
  end

  def example_input do
    """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """
  end
end

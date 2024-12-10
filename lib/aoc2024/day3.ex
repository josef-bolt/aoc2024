defmodule Aoc2024.Day3 do
  @moduledoc """
  https://adventofcode.com/2024/day/3
  """
  # 183788984
  def first(input \\ File.read!("priv/day3.txt")) do
    ~r/mul\(\d+,\d+\)/
    |> Regex.scan(input)
    |> Enum.map(fn [match | _] ->
      [_, x, y, _] = String.split(match, ["(", ")", ","])
      String.to_integer(x) * String.to_integer(y)
    end)
    |> Enum.sum()
  end

  # 62098619
  def second(input \\ File.read!("priv/day3.txt")) do
    matches = Regex.scan(~r/mul\(\d+,\d+\)|do\(\)|don't\(\)/, input)

    {enabled_matches, _} =
      Enum.reduce(matches, {[], true}, fn match, {acc, enabled?} ->
        case match do
          ["do()" | _] ->
            {acc, true}

          ["don't()" | _] ->
            {acc, false}

          [match | _] ->
            if enabled? do
              {[match | acc], enabled?}
            else
              {acc, enabled?}
            end
        end
      end)

    enabled_matches
    |> Enum.map(fn match ->
      [_, x, y, _] = String.split(match, ["(", ")", ","])
      String.to_integer(x) * String.to_integer(y)
    end)
    |> Enum.sum()
  end

  def example_input do
    """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """
  end

  def second_example do
    """
    xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    """
  end
end

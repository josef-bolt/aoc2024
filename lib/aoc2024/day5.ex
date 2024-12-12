defmodule Aoc2024.Day5 do
  @moduledoc """
  https://adventofcode.com/2024/day/5
  """

  def parse(input) do
    [rules, _, updates] =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.chunk_by(&(&1 == ""))

    parse_rule = fn rule ->
      rule
      |> String.split("|")
      |> Enum.map(&String.to_integer/1)
    end

    parse_update = fn update ->
      update
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end

    %{rules: Enum.map(rules, parse_rule), updates: Enum.map(updates, parse_update)}
  end

  # 4662
  def first(input \\ File.read!("priv/day5.txt")) do
    %{rules: rules, updates: updates} = parse(input)

    to_indexed_update = fn update ->
      update
      |> Enum.with_index()
      |> Map.new()
    end

    update_correct? = fn update ->
      update = to_indexed_update.(update)
      Enum.all?(rules, fn [earlier, later] ->
        if Map.has_key?(update, earlier) and Map.has_key?(update, later) do
          Map.get(update, earlier) < Map.get(update, later)
        else
          true
        end
      end)
    end

    updates
    |> Enum.filter(update_correct?)
    |> Enum.map(fn update ->
      len = Enum.count(update)
      Enum.at(update, div(len, 2))
    end)
    |> Enum.sum()
  end

  def second(input \\ File.read!("priv/day5.txt")) do
  end

  def example_input do
    """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """
  end
end

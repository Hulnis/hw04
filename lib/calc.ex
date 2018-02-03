defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Repeatedly prints a prompt and reads input, sends to eval
  """
  def main do
    input = IO.gets("Input your expression to be evaluated: ")
    parse_input(input)
    main()
  end

  @doc """
  parse through input once paranths have been dealt with, turning into prefix list using turn_to_prefix
  """
  def parse_input(input) do
    stack = []
    pre = input
    |> String.trim()
    |> String.split()
    |> turn_to_prefix(0, stack)
    |> mult_and_div(0, [])

    IO.inspect(pre)
  end

  @doc """
  Loops over array, creating a ternary structure of op, left, and right
  1 + 2 * 3 + 4
  """
  def turn_to_prefix(array, index, stack) when index + 1 < Kernel.length(array) do
    op = Enum.at(array, index + 1)
    stack =
      case op do
        "+" -> stack ++ ["+", elem(Float.parse(Enum.at(array, index)), 0)]
        "-" -> stack ++ ["-", elem(Float.parse(Enum.at(array, index)), 0)]
        "*" -> stack ++ ["*", elem(Float.parse(Enum.at(array, index)), 0), elem(Float.parse(Enum.at(array, index + 2)), 0)]
        "/" -> stack ++ ["/", elem(Float.parse(Enum.at(array, index)), 0), elem(Float.parse(Enum.at(array, index + 2)), 0)]
        _ -> "Error in the stack case"
      end
    index =
      case op do
        "+" -> index + 2
        "-" -> index + 2
        "*" -> index + 3
        "/" -> index + 3
        _ -> "Error in the index case"
      end
    turn_to_prefix(array, index, stack)
  end

  @doc """
  Will evaluate a basic arithmetic expression for the final element
  """
  def turn_to_prefix(array, index, stack) when index + 1 == Kernel.length(array) do
    stack ++ [elem(Float.parse(Enum.at(array, index)), 0)]
  end

  @doc """
  Will evaluate a basic arithmetic expression for no elements
  """
  def turn_to_prefix(array, index, stack) when index == Kernel.length(array) do
    stack
  end

  @doc """
  Will evaluate a basic arithmetic expression, calculating all * and / expressions
  """
  def mult_and_div(prefix_array, index, stack) when index + 1 < Kernel.length(prefix_array) do
    IO.inspect(prefix_array)
    next_elem = Enum.at(prefix_array, index)
    stack =
      case next_elem do
        "+" -> stack ++ ["+"]
        "-" -> index ++ ["-"]
        "*" -> stack ++ [Enum.at(prefix_array, index + 1) * Enum.at(prefix_array, index + 2)]
        "/" -> stack ++ [Enum.at(prefix_array, index + 1) / Enum.at(prefix_array, index + 2)]
        _ -> "Error in the index case"
      end
    index =
      case next_elem do
        "+" -> index + 1
        "-" -> index + 1
        "*" -> index + 3
        "/" -> index + 3
        _ -> "Error in the index case"
      end
    mult_and_div(prefix_array, index, stack)
  end

  @doc """
  Will evaluate a basic arithmetic expression, calculating all * and / expressions for the final element
  """
  def mult_and_div(prefix_array, index, stack) when index + 1 == Kernel.length(prefix_array) do
    stack ++ [elem(Float.parse(Enum.at(prefix_array, index)), 0)]
  end

  @doc """
  Will evaluate a basic arithmetic expression, calculating all * and / expressions for no elements
  """
  def mult_and_div(prefix_array, index, stack) when index == Kernel.length(prefix_array) do
    stack
  end
end

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
  parse through input once paranths have been dealt with, turning into prefix list using loop_over_array
  """
  def parse_input(input) do
    stack = []
    pre = input
    |> String.trim()
    |> String.split()
    |> loop_over_array(0, stack)

    IO.inspect(pre)
  end

  @doc """
  Loops over array, creating a ternary structure of op, left, and right
  1 + 2 * 3 +4
  """
  def loop_over_array(array, index, stack) when index + 1 < Kernel.length(array) do
    op = Enum.at(array, index + 1)
    case op do
      "+" -> stack ++ ["+", elem(Float.parse(Enum.at(array, index)), 0)]
      "-" -> stack ++ ["-", elem(Float.parse(Enum.at(array, index)), 0)]
      "/" -> stack ++ ["*", elem(Float.parse(Enum.at(array, index + 1)), 0), elem(Float.parse(Enum.at(array, index + 2)), 0)]
      "*" -> stack ++ ["/", elem(Float.parse(Enum.at(array, index + 1)), 0), elem(Float.parse(Enum.at(array, index + 2)), 0)]
      _ -> "Error"

    loop_over_array(array, index + 2, stack)
  end

  def loop_over_array(array, index, stack) when index + 1 == Kernel.length(array) do
    stack ++ [elem(Float.parse(Enum.at(array, index)), 0)]
  end

  @doc """
  Will evaluate a basic arithmetic expression, no parantheses
  """
  def basic_eval(line) do
    array = line
    |> String.trim()
    |> String.split()

    IO.inspect(array, label: "List is: ")
    num1 = elem(Float.parse(Enum.at(array, 0)), 0)
    num2 = elem(Float.parse(Enum.at(array, 2)), 0)
    op = Enum.at(array, 1)
    IO.puts(basic_math(num1, num2, op))
  end



  @doc """
  Does one math operation
  """
  def basic_math(num1, num2, op) do
    IO.inspect(num1)
    IO.inspect(num2)
    case op do
      "+" -> num1 + num2
      "-" -> num1 - num2
      "/" -> num1 / num2
      "*" -> num1 * num2
      _ -> "Error"
    end
  end
end

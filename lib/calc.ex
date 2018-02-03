defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Repeatedly prints a prompt and reads input, sends to eval
  """
  def main do
    input = IO.gets("Input your expression to be evaluated: ")
    IO.puts(basic_eval(input))
    main()
  end

  @doc """
  Will evaluate a basic arithmetic expression, no parantheses
  """
  def basic_eval(line) do
    line
    |> String.trim()
    |> String.split()
    |> basic_math()
  end

  @doc """
  Does one math operation
  """
  def basic_math(args) do
    num1 = Integer.parse(Enum.at(args, 0))
    op = Enum.at(args, 1)
    num2 = Integer.parse(Enum.at(args, 2))
    IO.puts(num1)
    IO.puts(op)
    IO.puts(num2)
    case op do
      "+" -> num1 + num2
      "-" -> num1 - num2
      "/" -> num1 / num2
      "*" -> num1 * num2
      _ -> "Error"
    end
  end
end

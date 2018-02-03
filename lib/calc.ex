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
    array = line
    |> String.trim()
    |> String.split()

    IO.inspect(array, label: "List is: ")
    num1 = FLoat.parse(Enum.at(array, 0))
    num2 = FLoat.parse(Enum.at(array, 2))
    op = Enum.at(array, 1)
    IO.puts(basic_math(num1, num2, op))
  end

  @doc """
  Does one math operation
  """
  def basic_math(num1, num2, op) do
    case op do
      "+" -> num1 + num2
      "-" -> num1 - num2
      "/" -> num1 / num2
      "*" -> num1 * num2
      _ -> "Error"
    end
  end
end

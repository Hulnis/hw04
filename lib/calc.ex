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
    | String.trim()
    | String.split()
    | IO.puts()
  end

  def print(basic) do
    IO.puts("please help")
  end
end

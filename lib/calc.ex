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
    split_string = input
    |> String.trim()
    |> String.split()

    pre = turn_to_prefix(split_string ++ [")"] ,0, ["("], [])

    IO.inspect(pre)
  end

  @doc """
  Loops over array, creating a ternary structure of op, left, and right
  1 + 2 * 3 + 4
  """
  def turn_to_prefix(array, index, op_stack, num_stack) when index < Kernel.length(array) do
    next_elem = Enum.at(array, index)
    IO.inspect(next_elem)
    IO.inspect(op_stack)
    IO.inspect(num_stack)
    IO.puts("-----------")
    if next_elem == "(" do
      turn_to_prefix(array, index + 1, op_stack ++ ["("], num_stack)
    end
    if next_elem == ")" do
      result = match_paranths(op_stack, num_stack)
      turn_to_prefix(array, index + 1, elem(result, 0), elem(result, 1))
    end
    if next_elem == "+" || next_elem == "-" || next_elem == "*" || next_elem == "/" do
      result = pop_ops(op_stack, num_stack, next_elem)
      turn_to_prefix(array, index + 1, elem(result, 0), elem(result, 1))
    else
      turn_to_prefix(array, index + 1, op_stack, num_stack ++ [next_elem])
    end
  end

  @doc """
  Loops over array, creating a ternary structure of op, left, and right
  1 + 2 * 3 + 4
  """
  def turn_to_prefix(array, index, op_stack, num_stack) when index >= Kernel.length(array) do
    {op_stack, num_stack}
  end

  @doc """
  pops elemnts from op_stack until we find close paranth
  """
  def match_paranths(op_stack, num_stack) do
    if List.last(op_stack) != "(" do
      op = List.last(op_stack)
      num2 = List.last(num_stack)
      num1 = List.last(num_stack)
      match_paranths(op_stack.delete(op), List.delete(List.delete(num_stack, num2), num1) ++ [op, num1, num2])
    else
      op_stack = op_stack.delete(List.last(op_stack))
      {op_stack, num_stack}
    end
  end

  @doc """
  Pops elements until finds an operator that comes after
  """
  def pop_ops(op_stack, num_stack, op) when Kernel.length(op_stack) >= 0 do
    next_op = List.last(op_stack)

    if next_op == "*" || next_op == "/" do
      num2 = List.last(num_stack)
      num1 = List.last(num_stack)
      pop_ops(op_stack.delete(next_op), num_stack.delete(num2).delete(num1) ++ [op, num1, num2])
    else
      {op_stack ++ [op], num_stack}
    end
  end
  @doc """
  Pops elements until finds an operator that comes after base case of empty stack
  """
  def pop_ops(op_stack, num_stack) when Kernel.length(op_stack) == 0 do
    op_stack = op_stack.delete(List.last(op_stack))
    {op_stack, num_stack}
  end
end

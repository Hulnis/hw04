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
  parse through input once paranths have been dealt with, turning into postfix list using turn_to_postfix
  """
  def parse_input(input) do
    post = input
    |> String.trim()
    |> String.split()
    |> turn_to_postfix(0, [], [])

    IO.inspect(post)
  end

  @doc """
  Loops over array, creating a postfix expressions
  1 + 2 * 3 + 4
  """
  def turn_to_postfix(array, index, op_stack, output) when index < Kernel.length(array) do
    next_elem = Enum.at(array, index)
    IO.inspect(next_elem)
    IO.inspect(op_stack)
    IO.inspect(output)
    IO.puts("-----------")
    if next_elem == "(" do
      turn_to_postfix(array, index + 1, op_stack ++ ["("], output)
    end
    if next_elem == ")" do
      result = match_paranths(op_stack, output)
      IO.puts("after )")
      IO.inspect(result)
      turn_to_postfix(array, index + 1, elem(result, 0), elem(result, 1))
    end
    if next_elem == "+" || next_elem == "-" || next_elem == "*" || next_elem == "/" do
      result = pop_ops(op_stack, output, next_elem)
      turn_to_postfix(array, index + 1, elem(result, 0), elem(result, 1))
    else
      turn_to_postfix(array, index + 1, op_stack, output ++ [next_elem])
    end
  end

  @doc """
  Loops over array, creating a ternary structure of op, left, and right
  1 + 2 * 3 + 4
  """
  def turn_to_postfix(array, index, op_stack, output) when index >= Kernel.length(array) do
    IO.puts("emptying stack")
    IO.inspect(op_stack)
    IO.inspect(output)
    empty_stack(op_stack, output)
  end

  def match_paranths(op_stack, output) do
    next_elem = List.last(op_stack)
    if next_elem != "(" do
      match_paranths(List.delete(op_stack, next_elem), output ++ [next_elem])
    end
      {List.delete(op_stack, next_elem), output}
  end

  def pop_ops(op_stack, output, op) do
    if Kernel.length(op_stack) > 0 do
      if op == "*" || op == "/" do
        {op_stack ++ [op], output}
      else
        next_elem = List.last(op_stack)
        result = pop_ops(List.delete(op_stack, next_elem), output, op)
        op_stack = elem(result, 0)
        output = elem(result, 1)
        {op_stack ++ [next_elem], output}
      end
    else
      {op_stack ++ [op], output}
    end
  end

  def empty_stack(stack, output) when Kernel.length(stack) > 0 do
    next_elem = List.last(stack)
    IO.puts("adding to output")
    IO.inspect(next_elem)
    empty_stack(List.delete(stack, next_elem), output ++ [next_elem])
  end

  def empty_stack(stack, output) when Kernel.length(stack) == 0 do
    output
  end
end

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
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split(" ",  trim: true)
    |> turn_to_postfix(0, [], [])
    |> eval_postfix([], 0)

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
    cond do
      next_elem == "(" ->
        turn_to_postfix(array, index + 1, op_stack ++ ["("], output)
      next_elem == ")" ->
        result = match_paranths(op_stack, output)
        IO.puts("after )")
        IO.inspect(result)
        turn_to_postfix(array, index + 1, elem(result, 0), elem(result, 1))
      next_elem == "+" || next_elem == "-" || next_elem == "*" || next_elem == "/" ->
        result = pop_ops(op_stack, output, next_elem)
        turn_to_postfix(array, index + 1, elem(result, 0), elem(result, 1))
      true ->
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
    else
      IO.puts("leaving match")
      {List.delete(op_stack, next_elem), output}
    end
  end

  def pop_ops(op_stack, output, op) do
    if Kernel.length(op_stack) > 0 do
      next_elem = List.last(op_stack)
      if op == "*" || op == "/" || next_elem == "(" do
        {op_stack ++ [op], output}
      else
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
    IO.puts("base case")
    IO.inspect(output)
    output
  end

  def eval_postfix(postfix, stack, index) when index < Kernel.length(postfix) do
    next_elem = Enum.at(postfix, index)
    cond do
      next_elem == "+" ->
        result = get_two_elem(stack)
        num1 = result[:num2]
        num2 = result[:num2]
        stack = result[:stack]
        IO.puts("Num 1 and 2")
        IO.inspect(num1)
        IO.inspect(num2)
        eval_postfix(postfix, stack ++ [num1 + num2], index + 1)
      next_elem == "-" ->
        num2 = List.last(stack)
        stack = List.delete(stack, num2)
        num2 = elem(Float.parse(num2), 0)
        num1 = List.last(stack)
        stack = List.delete(stack, num1)
        num1 = elem(Float.parse(num1), 0)
        eval_postfix(postfix, stack ++ [num1 - num2], index + 1)
      next_elem == "*" ->
        num2 = List.last(stack)
        stack = List.delete(stack, num2)
        num2 = elem(Float.parse(num2), 0)
        num1 = List.last(stack)
        stack = List.delete(stack, num1)
        num1 = elem(Float.parse(num1), 0)
        eval_postfix(postfix, stack ++ [num1 * num2], index + 1)
      next_elem == "/" ->
        num2 = List.last(stack)
        stack = List.delete(stack, num2)
        num2 = elem(Float.parse(num2), 0)
        num1 = List.last(stack)
        stack = List.delete(stack, num1)
        num1 = elem(Float.parse(num1), 0)
        eval_postfix(postfix, stack ++ [num1 / num2], index + 1)
      true ->
        IO.puts("adding to stack")
        IO.inspect(next_elem)
        IO.puts("------")
        eval_postfix(postfix, stack ++ [next_elem], index + 1)
    end
  end

  def eval_postfix(postfix, stack, index) when index >= Kernel.length(postfix) do
    Enum.at(stack, 0)
  end

  def get_two_elem(stack) do
    IO.puts("get two")
    IO.inspect(stack)
    num2 = List.last(stack)
    IO.puts("num2")
    IO.inspect(num2)
    stack = List.delete(stack, num2)
    IO.inspect(stack)
    num2 = elem(Float.parse(num2), 0)

    num1 = List.last(stack)
    stack = List.delete(stack, num1)
    num1 = elem(Float.parse(num1), 0)
    %{:num1 => num1, :num2 => num2, :stack => stack}
  end
end

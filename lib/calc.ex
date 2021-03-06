defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Repeatedly prints a prompt and reads input, sends to eval
  """
  def main do
    input = IO.gets("Input your expression to be evaluated: ")
    eval_expr(input)
    main()
  end

  @doc """
  parse through input once paranths have been dealt with, turning into postfix list using turn_to_postfix
  """
  def eval_expr(input) do
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
    cond do
      next_elem == "(" ->
        turn_to_postfix(array, index + 1, op_stack ++ ["("], output)
      next_elem == ")" ->
        result = match_paranths(op_stack, output)
        turn_to_postfix(array, index + 1, elem(result, 0), elem(result, 1))
      next_elem == "+" || next_elem == "-" || next_elem == "*" || next_elem == "/" ->
        result = pop_ops(op_stack, output, next_elem)
        turn_to_postfix(array, index + 1, elem(result, 0), elem(result, 1))
      true ->
        turn_to_postfix(array, index + 1, op_stack, output ++ [elem(Float.parse(next_elem), 0)])
    end
  end

  @doc """
  Loops over array, turning array into postfix
  """
  def turn_to_postfix(array, index, op_stack, output) when index >= Kernel.length(array) do
    empty_stack(op_stack, output)
  end

  @doc """
  Matches paranths, stopping when it finds an Open Paranth
  """
  def match_paranths(op_stack, output) do
    next_elem = List.last(op_stack)
    if next_elem != "(" do
      match_paranths(List.delete(op_stack, next_elem), output ++ [next_elem])
    else
      {List.delete(op_stack, next_elem), output}
    end
  end

  @doc """
  Pops ops off the stack until it finds one that the given op is above in the order, then inserts and returns
  """
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

  @doc """
  Moves everything left over from the stack to the output
  """
  def empty_stack(stack, output) when Kernel.length(stack) > 0 do
    next_elem = List.last(stack)
    empty_stack(List.delete(stack, next_elem), output ++ [next_elem])
  end

  @doc """
  Moves everything left over from the stack to the output
  """
  def empty_stack(stack, output) when Kernel.length(stack) == 0 do
    output
  end

  @doc """
  Evaluates postfix list into a float
  """
  def eval_postfix(postfix, stack, index) when index < Kernel.length(postfix) do
    next_elem = Enum.at(postfix, index)
    cond do
      next_elem == "+" ->
        result = get_two_elem(stack)
        num1 = result[:num1]
        num2 = result[:num2]
        stack = result[:stack]
        eval_postfix(postfix, stack ++ [num1 + num2], index + 1)
      next_elem == "-" ->
        result = get_two_elem(stack)
        num1 = result[:num1]
        num2 = result[:num2]
        stack = result[:stack]
        eval_postfix(postfix, stack ++ [num1 - num2], index + 1)
      next_elem == "*" ->
        result = get_two_elem(stack)
        num1 = result[:num1]
        num2 = result[:num2]
        stack = result[:stack]
        eval_postfix(postfix, stack ++ [num1 * num2], index + 1)
      next_elem == "/" ->
        result = get_two_elem(stack)
        num1 = result[:num1]
        num2 = result[:num2]
        stack = result[:stack]
        eval_postfix(postfix, stack ++ [num1 / num2], index + 1)
      true ->
        eval_postfix(postfix, stack ++ [next_elem], index + 1)
    end
  end

  def eval_postfix(postfix, stack, index) when index >= Kernel.length(postfix) do
    Enum.at(stack, 0)
  end

  def get_two_elem(stack) do
    num2 = List.last(stack)
    stack = List.delete(stack, num2)
    num1 = List.last(stack)
    stack = List.delete(stack, num1)
    %{:num1 => num1, :num2 => num2, :stack => stack}
  end
end

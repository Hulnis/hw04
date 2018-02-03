defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "basic test" do
    assert Calc.eval_expr("1 + 2") == 3
    assert Calc.eval_expr("1 - 2") == -1
    assert Calc.eval_expr("1 * 2") == 2
    assert Calc.eval_expr("1 / 2") == 0.5
    assert Calc.eval_expr("1 + 2 * 3") == 7
    assert Calc.eval_expr("(1 + 2) * 3") == 9
  end

  test "turn to postfix" do
    assert Calc.turn_to_postfix([1, "+", 2], 0, [], []) == [1, 2, "+"]
    assert Calc.turn_to_postfix([1, "-", 2], 0, [], []) == [1, 2, "-"]
    assert Calc.turn_to_postfix([1, "*", 2], 0, [], []) == [1, 2, "*"]
    assert Calc.turn_to_postfix([1, "/", 2], 0, [], []) == [1, 2, "/"]
    assert Calc.turn_to_postfix([1, "+", 2, "*", 3], 0, [], []) == [1, 2, 3, "*", "+"]
    assert Calc.turn_to_postfix(["(", 1, "+", 2, ")", "*", 3], 0, [], []) == [1, 2, 3, "+", "*"]
  end
end

defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "basic test" do
    assert Calc.eval_expr("1 + 2") == 3
    assert Calc.eval_expr("1 - 2") == -1
    assert Calc.eval_expr("1 * 2") == 2
    assert Calc.eval_expr("1 / 2") == .5
    assert Calc.eval_expr("1 + 2 * 3") == 7
    assert Calc.eval_expr("(1 + 2) * 3") == 9
  end
end

defmodule QuadraticEquation do
  @moduledoc """
  https://en.wikipedia.org/wiki/Quadratic_equation
  """

  @doc """
  function accepts 3 integer arguments and returns:
  {:roots, root_1, root_2} or {:root, root_1} or :no_root

  ## Examples
  iex> QuadraticEquation.solve(1, -2, -3)
  {:roots, 3.0, -1.0}
  iex> QuadraticEquation.solve(3, 5, 10)
  :no_roots
  """
  def solve(a, b, c) do
    discriminant = b**2 - 4*a*c
    case discriminant do
      d when b == 0 and -c/a > 0 -> {:roots, :math.sqrt(-c/a), -1 * :math.sqrt(-c/a)}
      d when d > 0 -> {:roots, (((-1*b)+ :math.sqrt(discriminant))/2*a), (((-1*b)- :math.sqrt(discriminant))/2*a)}
      d when d == 0 -> {:root, (-1*b)/2*a}
      d when d < 0 -> :no_roots
      _ -> "Ошибка"
    end
  end



end

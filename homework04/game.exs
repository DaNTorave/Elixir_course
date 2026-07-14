defmodule Game do

  def join_game(user) do
    # TODO add your implementation
    case user do
      {:user, name, age, :admin} -> :ok
      {:user, name, age, :moderator} -> :ok
      {:user, name, age, role} when age >= 18 -> :ok
      _ -> :error
    end
  end

  def move_allowed?(current_color, figure) do
    # TODO add your implementation
    case {current_color, figure} do
      {:white, {:pawn, :white}} -> true
      {:black, {:pawn, :black}} -> true
      {:white, {:rock, :white}} -> true
      {:black, {:rock, :black}} -> true
      _ -> false

    end
  end

  def single_win?(a_win, b_win) do
    # TODO add your implementation
    case {a_win, b_win} do
      {true, false} -> true
      {false, true} -> true
      _ -> false
    end

  end

  def double_win?(a_win, b_win, c_win) do
    # TODO add your implementation
    case {a_win, b_win, c_win} do
      {true, true, false} -> :ab
      {false, true, true} -> :bc
      {true, false, true} -> :ac
      _ -> false
    end
  end

end

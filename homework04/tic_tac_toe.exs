defmodule TicTacToe do

  @type cell :: :x | :o | :f
  @type row :: {cell, cell, cell}
  @type game_state :: {row, row, row}
  @type game_result :: {:win, :x} | {:win, :o} | :no_win

  @spec valid_game?(game_state) :: boolean
  def valid_game?(state) do
    # Enum.all?(список, условие через анонимную функцию) - проверяет чтобы все элементы списка подходили под условие
    # TODO add your implementation
    is_tuple(state) and tuple_size(state) == 3 and
    # Проверяет чтобы все строкив в списке были кортежами из трёх элементов
    Tuple.to_list(state) |> Enum.all?(fn row ->
      is_tuple(row) and tuple_size(row) == 3 and
    # Проверяет чтобы в строке были кортежи и с атомами :x, :o, :f
    Tuple.to_list(row) |> Enum.all?(fn cell ->
    cell in [:x, :o, :f]
      end)
    end)
  end

  @spec check_who_win(game_state) :: game_result
  def check_who_win(state) do
    rows = Tuple.to_list(state)

    cols = for i <- 0..2, do: {
      elem(elem(state, 0), i),
      elem(elem(state, 1), i),
      elem(elem(state, 2), i),
    }

    diagonals = [
      {elem(elem(state, 0), 0), elem(elem(state, 1), 1), elem(elem(state, 2), 2)},
      {elem(elem(state, 0), 2), elem(elem(state, 1), 1), elem(elem(state, 2), 0)},
    ]

    # Объединение в один большой список
    all_lines = rows ++ cols ++ diagonals

    # Enum.any?(список, условие через анонимную функцию) - проверяет чтобы хотя бы один элемент списка подходил под условие
    cond do
      Enum.any?(all_lines, fn line -> line == {:x, :x, :x} end) -> {:win, :x}
      Enum.any?(all_lines, fn line -> line == {:o, :o, :o} end) -> {:win, :o}
      true -> :no_win
    end
    # Можно было записать как
    # cond do
    #   rows == {:x, :x, :x} or cols == {:x, :x, :x} or diagonals == {:x, :x, :x} -> {:win, :x}
    #   rows == {:o, :o, :o} or cols == {:o, :o, :o} or diagonals == {:o, :o, :o} -> {:win, :o}
    #   true -> :no_win
    # end
  end
end

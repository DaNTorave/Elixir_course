defmodule MyList do

  @doc """
  Function takes a list that may contain any number of sublists,
  which themselves may contain sublists, to any depth.
  It returns the elements of these lists as a flat list.

  ## Examples
  iex> MyList.flatten([1, [2, 3], 4, [5, [6, 7, [8, 9, 10]]]])
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  """
  def flatten([]), do: []

  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)

  def flatten(item), do: [item]


  # ++ operator is not very effective.
  # It would be better to provide a more effective implementation,
  # which is possible, but a little bit tricky.
  def flatten_e(list) do
    # TODO add your implementation
    flatten_e(list, []) |> Enum.reverse()
  end

  defp flatten_e([], acc), do: acc

  defp flatten_e([head | tail], acc) when is_list(head) do
    flatten_e(tail, flatten_e(head, acc))
  end

  defp flatten_e([head | tail], acc) do
    flatten_e(tail, [head | acc])
  end

end

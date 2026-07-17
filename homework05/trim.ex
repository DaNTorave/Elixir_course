defmodule Trim do

  # We only trim space character
  def is_space(char), do: char == 32

  @doc """
  Function trim spaces in the beginning and in the end of the string.
  It accepts both single-quoted and double-quoted strings.

  ## Examples
  iex> Trim.trim('   hello there   ')
  'hello there'
  iex> Trim.trim("  Привет   мир  ")
  "Привет   мир"
  """
  def trim(str) when is_list(str) do
    # We iterate string 4 times here
    str
    |> trim_left
    |> Enum.reverse
    |> trim_left
    |> Enum.reverse
  end

  def trim(str) when is_binary(str) do
    # And yet 2 more iterations here
    str
    |> to_charlist
    |> trim
    |> to_string
  end


  defp trim_left([]), do: []
  defp trim_left([head | tail] = str) do
    if is_space(head) do
      trim_left(tail)
    else
      str
    end
  end


  def effective_trim(str) when is_list(str) do
    case find_first_and_last_non_space(str, 0, nil, nil) do
      {nil, _} -> []
      {first, last} -> Enum.slice(str, first..last)
    end
  end

  def effective_trim(str) when is_binary(str) do
    String.trim(str)
  end

  defp find_first_and_last_non_space([], _index, first, last) do
    {first, last}
  end

  defp find_first_and_last_non_space([head | tail], index, first, last) do
    if is_space(head) do
      find_first_and_last_non_space(tail, index + 1, first, last)
    else
      new_first = if first == nil, do: index, else: first
      find_first_and_last_non_space(tail, index + 1, new_first, index)
    end
  end
  
end

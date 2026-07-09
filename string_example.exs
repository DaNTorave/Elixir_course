defmodule StringExample do

  def example() do
    ["a", "bb", "ccc", "dddd", "eeeee"]
  end

  def align_words(words) do
    max_lenght = find_max_lenght(words)

    Enum.map(words, fn word -> align_word(word, max_lenght) end)

  end

  def find_max_lenght(words) do
    find_max_lenght(words, 0)
  end

  defp find_max_lenght([], current_max), do: current_max

  defp find_max_lenght([word | words], current_max) do
    current_max = max(String.length(word), current_max)
    find_max_lenght(words, current_max)
  end

  def align_word(word, length) do
    spaces = length - String.length(word)
    left_spaces = div(spaces, 2)
    right_spaces = spaces - left_spaces
    add_spaces(word, :right, spaces)

    word
    |> add_spaces(:right, right_spaces)
    |> add_spaces(:left, left_spaces)
  end

  def add_spaces(str, _, 0), do: str
  def add_spaces(str, :left, spaces), do: add_spaces(" " <> str, :left, spaces - 1)
  def add_spaces(str, :right, spaces), do: add_spaces(str <> " ", :right, spaces - 1)
end

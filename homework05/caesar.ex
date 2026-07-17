defmodule Caesar do

  # We consider only chars in range 32 - 126 as valid ascii chars
  # http://www.asciitable.com/
  @min_ascii_char 32
  @max_ascii_char 126
  @ascii_char_range (@max_ascii_char - @min_ascii_char + 1)

  @doc """
  Function shifts forward all characters in string. String could be double-quoted or single-quoted.

  ## Examples
  iex> Caesar.encode("Hello", 10)
  "Rovvy"
  iex> Caesar.encode('Hello', 5)
  'Mjqqt'
  """
  def encode(str, code) when is_binary(str) do
    str |> to_charlist() |> encode_charlist(code) |> List.to_string()
    # TODO add your implementation
  end

  def encode(str, code) when is_list(str) do
    encode_charlist(str, code)
  end

  defp encode_charlist([], _code), do: []

  defp encode_charlist([head | tail ], code) do
    [ head + code | encode_charlist(tail, code)]
  end

  @doc """
  Function shifts backward all characters in string. String could be double-quoted or single-quoted.

  ## Examples
  iex> Caesar.decode("Rovvy", 10)
  "Hello"
  iex> Caesar.decode('Mjqqt', 5)
  'Hello'
  """
  def decode(str, code) when is_binary(str) do
    # TODO add your implementation
    str |> to_charlist() |> decode_charlist(code) |> List.to_string()
  end

  def decode(str, code) when is_list(str) do
    # TODO add your implementation
    decode_charlist(str, code)
  end

  defp decode_charlist([], _code), do: []

  defp decode_charlist([head | tail ], code) do
    [ head - code | decode_charlist(tail, code)]
  end

  @doc ~S"""
  Function shifts forward all characters in string. String could be double-quoted or single-quoted.
  All characters should be in range 32-126, otherwise function raises RuntimeError with message "invalid ascii str"
  If result characters are out of valid range, than function wraps them to the beginning of the range.

  ## Examples
  iex> Caesar.encode_ascii('hello world', 15)
  'wt{{~/\'~\"{s'
  """
  defp validate_ascii([]), do: :ok

  defp validate_ascii([head | tail]) do
    if head < @min_ascii_char or head > @max_ascii_char do
      raise "invalid ascii str"
    else
      validate_ascii(tail)
    end
  end

  defp wrap_char(char) do
    if char > @max_ascii_char do
      @min_ascii_char + rem(char - @min_ascii_char, @ascii_char_range)
    else
      char
    end
  end

  defp unwrap_char(char) do
    if char < @min_ascii_char do
      @max_ascii_char - rem(@min_ascii_char - char - 1, @ascii_char_range)
    else
      char
    end
  end

  def encode_ascii(str, code) when is_binary(str) do
    # TODO add your implementation
    str |> to_charlist() |> encode_ascii_charlist(code) |> List.to_string()
  end

  def encode_ascii(str, code) when is_list(str) do
    encode_ascii_charlist(str, code)
  end

  def encode_ascii_charlist(chars, code) do
    validate_ascii(chars)
    do_encode_ascii(chars, code)
  end


  defp do_encode_ascii([], _code), do: []

  defp do_encode_ascii([head | tail], code) do
    shifted = head + code
    [wrap_char(shifted) | do_encode_ascii(tail, code)]
  end
  @doc ~S"""
  Function shifts backward all characters in string. String could be double-quoted or single-quoted.
  All characters should be in range 32-126, otherwise function raises RuntimeError with message "invalid ascii str"
  If result characters are out of valid range, than function wraps them to the end of the range.

  ## Examples
  iex> Caesar.decode_ascii('wt{{~/\'~\"{s', 15)
  'hello world'
  """
  def decode_ascii(str, code) when is_binary(str) do
    # TODO add your implementation
    str |> to_charlist() |> decode_ascii_charlist(code) |> List.to_string()
  end

  def decode_ascii(str, code) when is_list(str) do
    decode_ascii_charlist(str, code)
  end

  def decode_ascii_charlist(chars, code) do
    validate_ascii(chars)
    do_decode_ascii(chars, code)
  end

  defp do_decode_ascii([], _code), do: []

  defp do_decode_ascii([head | tail], code) do
    shifted = head - code
    [unwrap_char(shifted) | do_decode_ascii(tail, code)]
  end

end

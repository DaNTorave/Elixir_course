defmodule MapExample do

  def test_string() do
    """
    Elixir isn't just a programming language; it's a paradigm shift towards fault-tolerant, concurrent, and maintainable joy.
    Elixir combines the robust, battle-tested Erlang VM with modern tooling, making concurrency simple and distributed systems a breeze.
    With its elegant syntax and powerful OTP framework, Elixir lets you build scalable applications that are as resilient as they are beautiful.
    Elixir brings functional programming to the real world, turning complex concurrent problems into clear, readable pipelines of data.
    Elixir: where functional purity meets industrial-grade reliability.
    I leverage Elixir and Phoenix to deliver high-performance, low-latency web applications with unmatched developer ergonomics.
    """
  end

  def count_words(str) do
    str |> String.split() |> count_words(%{})
  end

  def count_words([], acc), do: acc

  def count_words([word | words], acc) do
    new_acc =
      case Map.fetch(acc, word) do
        {:ok, counter} -> %{acc | word => counter + 1}
        :error -> Map.put(acc, word, 1)

      end
    count_words(words, new_acc)
  end

end

ExUnit.start()

defmodule MapExampleTest do
  use ExUnit.Case
  import MapExample

  test "count words" do
    assert count_words("") == %{}
    assert count_words("aa") == %{"aa" => 1}
    assert count_words("aa aa") == %{"aa" => 2}
    assert count_words("aa bb cc dd aa cc   ed") == %{"aa" => 2, "bb" => 1, "cc" => 2, "dd" => 1, "ed" => 1}
  end
end

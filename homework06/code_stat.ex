defmodule CodeStat do
  @types [
    {"Elixir", [".ex", ".exs"]},
    {"Erlang", [".erl"]},
    {"Python", [".py"]},
    {"JavaScript", [".js"]},
    {"SQL", [".sql"]},
    {"JSON", [".json"]},
    {"Web", [".html", ".htm", ".css"]},
    {"Scripts", [".sh", ".lua", ".j2"]},
    {"Configs", [".yaml", ".yml", ".conf", ".args", ".env"]},
    {"Docs", [".md"]}
  ]

  @ignore_names [".git", ".gitignore", ".idea", "_build", "deps", "log", ".formatter.exs"]
  @ignore_extensions [".beam", ".lock", ".iml", ".log", ".pyc"]
  @max_depth 5

  def analyze(path) do
    ext_to_type = Enum.flat_map(@types, fn {type, extensions} ->
      Enum.map(extensions, &{&1, type})
    end) |> Map.new()

    initial = default_stats()

    path
    |> all_files(0)
    |> Enum.filter(&File.regular?/1)
    |> Enum.reject(&ignored?/1)
    |> Enum.reduce(initial, fn file, acc ->
      ext = Path.extname(file)
      type = Map.get(ext_to_type, ext, "Other")
      content = File.read!(file)
      lines = count_lines(content)
      size = byte_size(content)

      update_in(acc, [type], fn stats ->
        %{stats | files: stats.files + 1, lines: stats.lines + lines, size: stats.size + size}
      end)
    end)
  end

  defp all_files(_path, depth) when depth >= @max_depth, do: []
  defp all_files(path, depth) do
    case File.ls(path) do
      {:ok, entries} ->
        entries
        |> Enum.flat_map(fn entry ->
          full_path = Path.join(path, entry)

          cond do
            ignored?(full_path) -> []
            File.dir?(full_path) -> all_files(full_path, depth + 1)
            true -> [full_path]
          end
        end)
      {:error, _} -> []
    end
  end

  defp count_lines(content), do: String.split(content, "\n") |> length()

  defp ignored?(path) do
    path_parts = Path.split(path)


    Enum.any?(@ignore_names, fn ignore ->
      Enum.any?(path_parts, &(&1 == ignore))
    end) or

    Enum.any?(@ignore_extensions, &(Path.extname(path) == &1))
  end

  defp default_stats() do
    types = Enum.map(@types, fn {type, _} -> type end) ++ ["Other"]
    Map.new(types, &{&1, %{files: 0, lines: 0, size: 0}})
  end
end

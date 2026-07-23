defmodule MyMusicBand.Vocalist do

  @valid_sounds [:'A-a-a', :'O-o-o', :'E-e-e', :'Wooo', :' ']

  def init(sounds) when is_list(sounds) do
    invalid = sounds
    |> Enum.with_index(1)
    |> Enum.filter(fn {sound, _index} -> not valid_sounds?(sound) end)
    |> Enum.map(fn {sound, index} -> {index, sound} end)

    if invalid == [] do
      {:ok, {0, sounds}}
    else
      {:error, invalid}
    end
  end


  def next({index, sounds}) do
    sound = Enum.at(sounds, index)
    next_index = rem(index + 1, length(sounds))
    {sound, {next_index, sounds}}
  end

  defp valid_sounds?(sound) do
    sound in @valid_sounds
  end
end

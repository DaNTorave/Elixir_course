defmodule MyMusicBand.Band do
  alias MyMusicBand.Drummer
  alias MyMusicBand.Guitarist
  alias MyMusicBand.Vocalist

  @type player_state :: {non_neg_integer(), list()}
  @type band_state :: %{
    vocalist: player_state() | nil,
    guitarist: player_state() | nil,
    drummer: player_state() | nil,
  }

  def init() do
    %{
      vocalist: nil,
      guitarist: nil,
      drummer: nil
    }
  end


  def add_player(band, player_state) do
    cond do
      band.vocalist == nil ->
        %{band | vocalist: player_state}
      band.guitarist == nil ->
        %{band | guitarist: player_state}
      band.drummer == nil ->
        %{band | drummer: player_state}
      true -> band
    end
  end

  def next(band) do
    if band.vocalist == nil or band.guitarist == nil or band.drummer == nil do
      raise "Band is not fully assembled!"
    end

    {vocal_sound, new_vocalist} = Vocalist.next(band.vocalist)
    {guitar_sound, new_guitarist} = Guitarist.next(band.guitarist)
    {drum_sound, new_drummer} = Drummer.next(band.drummer)

    sounds = [vocal_sound, guitar_sound, drum_sound]

    new_band = %{
      vocalist: new_vocalist,
      guitarist: new_guitarist,
      drummer: new_drummer
    }

    {sounds, new_band}
  end

end

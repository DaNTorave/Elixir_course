defmodule WorldChamp do

  def sample_champ() do
    [
      {
        :team, "Crazy Bulls",
        [
          {:player, "Big Bull", 22, 545, 99},
          {:player, "Small Bull", 18, 324, 95},
          {:player, "Bull Bob", 19, 32, 45},
          {:player, "Bill The Bull", 23, 132, 85},
          {:player, "Tall Ball Bull", 38, 50, 50},
          {:player, "Bull Dog", 35, 201, 91},
          {:player, "Bull Tool", 29, 77, 96},
          {:player, "Mighty Bull", 22, 145, 98}
        ]
      },
      {
        :team, "Cool Horses",
        [
          {:player, "Lazy Horse", 21, 423, 80},
          {:player, "Sleepy Horse", 23, 101, 35},
          {:player, "Horse Doors", 19, 87, 23},
          {:player, "Rainbow", 21, 200, 17},
          {:player, "HoHoHorse", 20, 182, 44},
          {:player, "Pony", 25, 96, 76},
          {:player, "Hippo", 17, 111, 96},
          {:player, "Hop-Hop", 31, 124, 49}
        ]
      },
      {
        :team, "Fast Cows",
        [
          {:player, "Flash Cow", 18, 56, 34},
          {:player, "Cow Bow", 28, 89, 90},
          {:player, "Boom! Cow", 20, 131, 99},
          {:player, "Light Speed Cow", 21, 201, 98},
          {:player, "Big Horn", 23, 38, 93},
          {:player, "Milky", 25, 92, 95},
          {:player, "Jumping Cow", 19, 400, 98},
          {:player, "Cow Flow", 18, 328, 47}
        ]
      },
      {
        :team, "Fury Hens",
        [
          {:player, "Ben The Hen", 57, 403, 83},
          {:player, "Hen Hen", 20, 301, 56},
          {:player, "Son of Hen", 21, 499, 43},
          {:player, "Beak", 22, 35, 96},
          {:player, "Superhen", 27, 12, 26},
          {:player, "Henman", 20, 76, 38},
          {:player, "Farm Hen", 18, 131, 47},
          {:player, "Henwood", 40, 198, 77}
        ]
      },
      {
        :team, "Extinct Monsters",
        [
          {:player, "T-Rex", 21, 999, 99},
          {:player, "Velociraptor", 29, 656, 99},
          {:player, "Giant Mammoth", 30, 382, 99},
          {:player, "The Big Croc", 42, 632, 99},
          {:player, "Huge Pig", 18, 125, 98},
          {:player, "Saber-Tooth", 19, 767, 97},
          {:player, "Beer Bear", 24, 241, 99},
          {:player, "Pure Horror", 31, 90, 43}
        ]
      }
    ]
  end


  def get_stat(champ) do
    # TODO add your implementation
    num_teams = length(champ)
    all_players = champ |> Enum.flat_map(fn {:team, _name, players} -> players end)
    num_players = length(all_players)
    {total_age, total_rating} = all_players
    |> Enum.reduce({0, 0}, fn {:player, _name, age, rating, _health}, {sum_age, sum_rating} -> {sum_age + age, sum_rating + rating} end)

    avg_age = total_age / num_players
    avg_rating = total_rating / num_players

    {num_teams, num_players, avg_age, avg_rating}
  end


  def examine_champ(champ) do
    # TODO add your implementation
    champ
      |> Enum.map(fn {:team, name, players} ->
        filtered_players = players
        |> Enum.filter(fn {:player, _, _, _, health} -> health >= 50 end)
        {:team, name, filtered_players}
      end)
      |> Enum.filter(fn {:team, _, players} ->
        length(players) >= 5
      end)

  end

  def make_pairs(team1, team2) do
    # TODO add your implementation
    players1 = case team1 do
      {:team, _name1, players} -> players
    end
    players2 = case team2 do
      {:team, _name2, players} -> players
    end
    Enum.flat_map(players1, fn {:player, name1, _age, rating1, _health} ->
      Enum.flat_map(players2, fn {:player, name2, _age, rating2, _health} ->
        if rating1 + rating2 > 600 do
          [{name1, name2}]
        else
          []
        end
      end)
    end)
  end

end

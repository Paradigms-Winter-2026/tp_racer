defmodule TpRacer.Games.Game do
  use Ecto.Schema

  schema "games" do
    field :start_time, :utc_datetime

    # The game customization option: how many words to get from the word bank
    # For UI only (sorting/grouping games), not for calculating WPM.
    field :word_count, :integer

    # This one is for WPM. A word is defined as 5 characters.
    field :character_count, :integer

    has_many :game_players, TpRacer.Games.GamePlayer
  end
end

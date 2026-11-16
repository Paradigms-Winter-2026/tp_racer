defmodule TpRacer.Games.GamePlayer do
  use Ecto.Schema

  @primary_key false
  schema "game_players" do
    belongs_to :game, TpRacer.Games.Game, primary_key: true
    belongs_to :user, TpRacer.Accounts.User, primary_key: true

    # All these are null if the player does not finish the game.

    # For WPM and total play time
    field :play_ms, :integer
    field :ranking, :integer
    # Including wrong ones
    field :characters_typed, :integer

    # Can be derived:
    # 	accuracy = game.character_count / characters_typed * 100
    # 	raw WPM = (characters_typed / 5) / (play_ms / 60000)
    # 	net WPM = (game.character_count / 5) / (play_ms / 60000)
    # Technically ranking is also derivable (row index order by play_ms),
    # but it's easier to just store.
  end
end

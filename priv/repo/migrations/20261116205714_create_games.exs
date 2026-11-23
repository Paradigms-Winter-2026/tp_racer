defmodule TpRacer.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add(:start_time, :utc_datetime,
        null: false,
        default: fragment("timezone('UTC', now())")
      )

      add(:word_count, :integer, null: false)
      add(:character_count, :integer, null: false)
    end

    create table(:game_players, primary_key: false) do
      add(:game_id, references(:games, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      add(:play_ms, :integer, null: true)
      add(:ranking, :integer, null: true)
      add(:characters_typed, :integer, null: true)
    end

    create index(:game_players, [:user_id])

    create constraint(:game_players, :consistent_nullability,
             check: """
             (play_ms IS NULL AND ranking IS NULL AND characters_typed IS NULL)
             OR
             (play_ms IS NOT NULL AND ranking IS NOT NULL AND characters_typed IS NOT NULL)
             """
           )
  end
end

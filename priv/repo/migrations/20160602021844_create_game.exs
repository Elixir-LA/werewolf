defmodule Werewolf.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :slug, :string

      timestamps
    end

  end
end

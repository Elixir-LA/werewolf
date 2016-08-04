defmodule Werewolf.Repo.Migrations.CreateUsernameIndex do
  use Ecto.Migration

  def change do
    create index(:users, [:name], unique: true)
  end
end

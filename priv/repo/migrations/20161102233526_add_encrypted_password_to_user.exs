defmodule Werewolf.Repo.Migrations.AddEncryptedPasswordToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :encrypted_password, :string
    end
  end
end

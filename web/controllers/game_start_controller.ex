defmodule Werewolf.GameStartController do
  use Werewolf.Web, :controller

  alias Werewolf.Game
  alias Werewolf.User

  def create(conn, params) do
    changeset = Game.changeset(%Game{slug: generate_slug})

    case Repo.insert(changeset) do
      {:ok, _game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp generate_slug do
    #Date.now(:secs)
    :rand.uniform(1000000)
    |> generate_hash
  end

  defp generate_hash(id) do
    hashids = Hashids.new(
      salt: "samoelixir",
      min_len: 4
    )
    Hashids.encode(hashids, id)
  end
end


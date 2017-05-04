defmodule Werewolf.GameCreateController do
  use Werewolf.Web, :controller

  alias Werewolf.Game
  plug Werewolf.Plug.Authenticate

  def create(conn, _) do
    changeset = Game.changeset(%Game{slug: generate_slug})

    case Repo.insert(changeset) do
      {:ok, game} ->
        conn
        |> start_game(game)
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :show, game.slug))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp start_game(conn, game) do
    game.slug
    |> String.to_atom
    |> Werewolf.Gameplay.Supervisor.create_game
    conn
  end

  defp generate_slug do
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

defmodule Werewolf.SessionController do
  use Werewolf.Web, :controller

  alias Werewolf.Game

  def create(conn, %{"game" => %{"slug" => slug, "name" => name}}) do
    # changeset = Game.changeset(%Game{slug: generate_slug})

    # case Repo.insert(changeset) do
    #   {:ok, game} ->
        conn
        |> put_flash(:info, "Game joined successfully.")
        |> put_session(:user_name, name)
        |> redirect(to: game_path(conn, :show, slug))
      # {:error, changeset} ->
      #   render(conn, "new.html", changeset: changeset)
    # end
  end
end

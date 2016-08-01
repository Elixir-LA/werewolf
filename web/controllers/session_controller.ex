defmodule Werewolf.SessionController do
  use Werewolf.Web, :controller

  alias Werewolf.Game

  def create(conn, %{"game" => %{"name" => user_name, "slug" => slug}}) do
    case Repo.get_by(Game, slug: slug) do
      nil ->
        conn
        |> put_flash(:error, "Sorry, I can't find that game!")
        |> redirect(to: page_path(conn, :index))
      game ->
        conn
        |> put_flash(:info, "You have joined, #{user_name}!")
        |> put_session(:user_name, user_name)
        |> redirect(to: game_path(conn, :show, game.slug))
    end
  end
end

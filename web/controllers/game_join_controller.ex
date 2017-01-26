defmodule Werewolf.GameJoinController do
  use Werewolf.Web, :controller

  alias Werewolf.Game
  plug Werewolf.Plug.Authenticate
  def create(conn, %{"game" => %{"slug" => slug}}) do
    case Repo.get_by(Game, slug: slug) do
      nil ->
        conn
        |> put_flash(:error, "Sorry, I can't find that game!")
        |> redirect(to: page_path(conn, :index))
      game ->
        conn
        |> put_flash(:info, "You have joined, #{conn.assigns.current_user.name}!")
        |> redirect(to: game_path(conn, :show, game.slug))
    end
  end
end
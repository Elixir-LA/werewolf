defmodule Werewolf.PageController do
  use Werewolf.Web, :controller
  alias Werewolf.Game

  def index(conn, _params) do
    conn
    |> assign(:changeset, Game.changeset(%Game{}))
    |> render("index.html")
  end
end

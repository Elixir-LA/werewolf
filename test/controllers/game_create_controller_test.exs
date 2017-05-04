defmodule Werewolf.GameCreateControllerTest do
  use Werewolf.ConnCase

  alias Werewolf.Game
  alias Ecto.Query

  @valid_attrs %{name: "Albert Gamer"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn = conn |> put_private(:authenticated_current_user, %{name: "Albert Gamer"})
    {:ok, conn: conn}
  end

  test "#create creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, game_create_path(conn, :create), game: @valid_attrs
    game = Game |> Query.last |> Repo.one
    assert redirected_to(conn) == game_path(conn, :show, game.slug)
    assert Repo.get_by(Game, %{slug: game.slug})
  end

end

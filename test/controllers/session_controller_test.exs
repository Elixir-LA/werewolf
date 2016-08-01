defmodule Werewolf.SessionControllerTest do
  use Werewolf.ConnCase

  alias Werewolf.Game
  alias Ecto.Query

  @valid_attrs %{name: "Albert Gamer", slug: "abcd"}
  @invalid_attrs %{}

  test "#create redirects to the game endpoint if the slug is found", %{conn: conn} do
    slug = "abcd"
    changeset = Game.changeset(%Game{slug: slug})
    {:ok, _} = Repo.insert(changeset)

    conn = post conn, session_path(conn, :create), game: @valid_attrs
    assert redirected_to(conn) == game_path(conn, :show, slug)
    assert Repo.get_by(Game, %{slug: slug})
  end

  test "#create redirects back to the main page if the slug is not found", %{conn: conn} do
    conn = post conn, session_path(conn, :create), game: @valid_attrs
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "#create stores the user name in the session", %{conn: conn} do
    slug = "abcd"
    changeset = Game.changeset(%Game{slug: slug})
    {:ok, _} = Repo.insert(changeset)

    conn = post conn, session_path(conn, :create), game: @valid_attrs
    session_user_name = conn |> get_session(:user_name)
    assert session_user_name == "Albert Gamer"
  end
end

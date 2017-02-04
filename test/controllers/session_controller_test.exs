defmodule Werewolf.SessionControllerTest do
  use Werewolf.ConnCase

  alias Werewolf.User
  alias Ecto.Query
  import Werewolf.Password, only: [generate_password_and_store_user: 1]
  def add_valid_user(_context) do
    {:ok, %{
      valid_user: %{
        name: "Albert Gamer",
        password: "applesauce",
        password_confirmation: "applesauce"
      } 
    }}
  end

  def add_correct_login_attrs(_context) do
    {:ok, %{
      correct_login_attrs: %{name: "Albert Gamer", password: "applesauce"}
    }}
  end

  def add_incorrect_password_attrs(_context) do
    {:ok, %{
      incorrect_password_attrs: %{name: "Albert Gamer", password: "cheese"}
    }}
  end

  def add_user_missing_attrs(_context) do
    {:ok, %{
      user_missing_attrs: %{name: "Jim Gamer", password: "applesauce"}
    }}
  end

  def add_missing_parameter_attrs(_context) do
    {:ok, %{
      missing_parameter_attrs: %{}
    }}
  end

  setup [:add_valid_user, :add_correct_login_attrs, :add_incorrect_password_attrs, :add_user_missing_attrs, :add_missing_parameter_attrs]
  

  test "#create logs in with existing user and correct password", %{conn: conn, valid_user: valid_user, correct_login_attrs: attrs} do
    user = User.changeset(%User{}, valid_user)
    generate_password_and_store_user(user)
    conn = post conn, session_path(conn, :create), user: attrs
    assert redirected_to(conn) == page_path(conn, :index)
    assert get_session(conn, :current_user) == Repo.get_by(User, name: valid_user.name)
  end

  test "#create with existing user and incorrect password rerenders form", %{conn: conn} do
  end

  test "#create with nonexistent user rerenders form", %{conn: conn} do
  end

  test "#create with missing parameters rerenders form", %{conn: conn} do
  end
end

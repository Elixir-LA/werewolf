defmodule Werewolf.UserTest do
  use Werewolf.ModelCase

  alias Werewolf.User

  @valid_attrs %{name: "some content", 
    password: "applesauce",
    password_confirmation: "applesauce"}
  @missing_required_attrs %{
    password: "applesauce",
    password_confirmation: "applesauce"
  }
  @passwords_do_not_match_attrs %{
    name: "some content",
    password: "applesauce",
    password_confirmation: "not applesauce"
  }
  @passwords_not_long_enough_attrs %{
    name: "some content",
    password: "app",
    password_confirmation: "app"
  }

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset missing required params" do
    changeset = User.changeset(%User{}, @missing_required_attrs)
    refute changeset.valid?
  end

  test "changeset passwords don't match" do
    changeset = User.changeset(%User{}, @passwords_do_not_match_attrs)
    refute changeset.valid?
  end

  test "changeset passwords not long enough" do
    changeset = User.changeset(%User{}, @passwords_not_long_enough_attrs)
    refute changeset.valid?
  end

  test "changeset username not unique" do
    changeset = User.changeset(%User{}, @valid_attrs)
    Repo.insert(changeset)
    new_changeset = User.changeset(%User{}, @valid_attrs)
    assert match?({:error, _},Repo.insert(new_changeset))
  end
end

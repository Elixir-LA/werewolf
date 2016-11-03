defmodule Werewolf.PasswordTest do
  use Werewolf.ModelCase

  alias Werewolf.User
  alias Werewolf.Password

  @valid_attrs %{name: "some content", 
    password: "applesauce",
    password_confirmation: "applesauce"}

  test "it generates an encrypted password and stores a user" do
    changeset = User.changeset(%User{}, @valid_attrs)
    {:ok, user} = Password.generate_password_and_store_user(changeset)
    assert user.encrypted_password
    assert String.length(user.encrypted_password) > 0
  end
end
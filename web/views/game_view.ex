defmodule Werewolf.GameView do
  use Werewolf.Web, :view

  def user_message(nil), do: "You are really not logged in "
  def user_message(name), do: "Hello, #{name}"

end

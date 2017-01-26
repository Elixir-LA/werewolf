defmodule Werewolf.Plug.CurrentUser do
  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    current_user = get_session(conn, :current_user)
    assign(conn, :current_user, current_user)
  end
end
defmodule Werewolf.Plug.Authenticate do
  import Plug.Conn
  import Werewolf.Router.Helpers
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    case conn |> current_user do
      nil ->
         conn
          |> put_flash(:error, 'You need to be signed in to view this page')
          |> redirect(to: session_path(conn, :new))
          |> halt
      current_user ->
        assign(conn, :current_user, current_user)
    end
  end

  defp current_user(conn) do
    case Mix.env do
      :test ->
        conn.private[:authenticated_current_user]
      _ ->
        conn |> get_session(:current_user)
    end
  end
end
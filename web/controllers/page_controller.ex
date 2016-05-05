defmodule Werewolf.PageController do
  use Werewolf.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

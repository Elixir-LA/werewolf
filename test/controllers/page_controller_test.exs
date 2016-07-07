defmodule Werewolf.PageControllerTest do
  use Werewolf.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Werewolf"
  end
end

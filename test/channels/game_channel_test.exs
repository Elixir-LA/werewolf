defmodule Werewolf.GameChannelTest do
  use Werewolf.ChannelCase

  alias Werewolf.GameChannel
  alias Werewolf.UserSocket
  alias Werewolf.Gameplay

  setup do
    {:ok, socket} = connect(UserSocket, %{"user" => "bilbo"})
    gameplay = Gameplay.Supervisor.create_game(:abcd123)
    {:ok, _, socket} = subscribe_and_join(socket, GameChannel, "games:abcd123")

    {:ok, socket: socket, gameplay: gameplay}
  end

  test "message:new broadcasts to games:abcd123", %{socket: socket} do
    push socket, "message:new", "Hello!"
    assert_broadcast "message:new", %{ body: "Hello!", user: "bilbo"}
  end

end

defmodule Werewolf.RoomChannelTest do
  use Werewolf.ChannelCase

  alias Werewolf.RoomChannel
  alias Werewolf.UserSocket

  setup do
    {:ok, socket} = connect(UserSocket, %{"user" => "bilbo"})
    {:ok, _, socket} = subscribe_and_join(socket, RoomChannel, "rooms:lobby")

    {:ok, socket: socket}
  end

  test "message:new broadcasts to room:lobby", %{socket: socket} do
    push socket, "message:new", "Hello!"
    assert_broadcast "message:new", %{ body: "Hello!", user: "bilbo"}
  end

end

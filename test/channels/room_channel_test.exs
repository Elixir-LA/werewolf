defmodule Werewolf.RoomChannelTest do
  use Werewolf.ChannelCase

  alias Werewolf.RoomChannel
  alias Werewolf.UserSocket

  setup do
    {:ok, socket} = connect(UserSocket, %{"user" => "bilbo"})
    {:ok, _, socket} = subscribe_and_join(socket, RoomChannel, "room:lobby")

    {:ok, socket: socket}
  end


end

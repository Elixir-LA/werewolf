defmodule Werewolf.RoomChannel do
  use Werewolf.Web, :channel

  def join("rooms:lobby", _payload, socket) do
    {:ok, socket}
  end

end

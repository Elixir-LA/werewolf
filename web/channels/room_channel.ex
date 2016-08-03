defmodule Werewolf.RoomChannel do
  use Werewolf.Web, :channel

  def join("rooms:lobby", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("message:new", message, socket) do
    broadcast! socket, "message:new", %{
      user: socket.assigns.user,
      body: message,
      timestamp: :os.system_time(:milli_seconds)
    }
    {:noreply, socket}
  end

end

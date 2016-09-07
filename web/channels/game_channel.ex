defmodule Werewolf.GameChannel do
  use Werewolf.Web, :channel
  alias Werewolf.Presence
  alias Werewolf.Gameplay

  def join("games:" <> game_id, _payload, socket) do
    player_id = socket.assigns.user

    case Gameplay.join(game_id, player_id, socket.channel_pid) do
      {:ok, _pid} ->
        send(self, :after_join)
        {:ok, socket}
      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end

  def handle_in("message:new", message, socket) do
    broadcast! socket, "message:new", %{
      user: socket.assigns.user,
      body: message,
      timestamp: :os.system_time(:milli_seconds)
    }
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

end

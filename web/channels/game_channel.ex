defmodule Werewolf.GameChannel do
  use Werewolf.Web, :channel
  alias Werewolf.Presence
  alias Werewolf.Gameplay

  def join("games:" <> game_id, _payload, socket) do
    assign(socket, :game_id, game_id) |>
      game_join(game_id)
  end

  def game_join(socket, game_id) do
    player_id = socket.assigns.user
    case Gameplay.join(game_id, player_id, socket.channel_pid) do
      {:ok, _pid, game_state} ->
        send(self, :after_join)
        {:ok, game_state, socket}
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

  def handle_in("game:start", _, socket) do
    case Gameplay.start_game(socket.assigns.game_id, socket.channel_pid) do
      {:ok, _pid} ->
        send(self, :after_game_start)
        {:noreply, socket}
      {:error, reason} ->
        {:reply, %{status: :error, response: %{reason: reason}}, socket}
    end
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_info(:after_game_start, socket) do
    broadcast! socket, "game:start", %{}
    {:noreply, socket}
  end
end

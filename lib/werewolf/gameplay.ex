defmodule Werewolf.Gameplay do
  use GenServer

  defstruct [
    id: nil,
    players: []
  ]

  # CLIENT
  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: ref(game_id))
  end

  def join(game_id, player_id, pid) do
    try_call(game_id, {:join, player_id, pid})
  end

  # SERVER
  def init(id) do
    {:ok, %__MODULE__{id: id}}
  end

  def handle_call({:join, player_id, pid}, _from, game) do
    updated_players = Enum.dedup(game.players ++ [player_id])
    game = %{game | players: updated_players}
    |> IO.inspect
    {:reply, {:ok, self}, game}
  end

  defp ref(game_id), do: {:global, {:gameplay, game_id}}

  defp try_call(game_id, message) do
    case GenServer.whereis(ref(game_id)) do
      nil ->
        {:error, "Game does not exist"}
      pid ->
        GenServer.call(pid, message)
    end
  end
end

defmodule Werewolf.Gameplay do
  use GenServer
  alias Werewolf.{GameplayHelper}
  import GameplayHelper

  defstruct [
    id: nil,
    game_started: false,
    players: []
  ]

  # CLIENT
  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: ref(game_id))
  end

  def join(game_id, player_id, pid) do
    try_call(game_id, {:join, player_id, pid})
  end

  def start_game(game_id, pid) do
    try_call(game_id, {:start_game, pid})
  end

  # SERVER
  def init(game_id, tid) do
    saved_state = :ets.lookup(tid, :game) |> initial_state(game_id)
    {:ok, {tid, saved_state}}
  end

  def initial_state([], game_id) do
    %__MODULE__{id: game_id}
  end

  def initial_state(state, _game_id) do
    state
  end

  def handle_call({:join, player_id, _pid}, _from, {tid, game}) do
    updated_players = Enum.dedup(game.players ++ [player_id])
    game = %{game | players: updated_players}
    |> IO.inspect
    :ets.insert(:game, game)
    {:reply, {:ok, self}, {tid, game}}
  end

  def handle_call({:start_game, _pid}, _from, {tid, game}) do
    new_game = %{game | game_started: true}
    |> IO.inspect
    :ets.insert(:game, new_game)
    {:reply, {:ok, self}, {tid, new_game}}
  end

  defp try_call(game_id, message) do
    case GenServer.whereis(ref(game_id)) do
      nil ->
        {:error, "Game does not exist"}
      pid ->
        GenServer.call(pid, message)
    end
  end
end

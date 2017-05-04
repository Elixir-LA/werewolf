defmodule Werewolf.Gameplay.Persister do
  use Supervisor
  alias Werewolf.{Gameplay, GameplayHelper}
  import GameplayHelper

  def init(game_id) do
    tid = :ets.new(game_id, [:set, :public])
    children = [
      worker(Gameplay, [{tid, game_id}], restart: :transient)
    ]
    supervise(children, strategy: :one_for_one)
  end


  def start_link(game_id) do
    Supervisor.start_link(__MODULE__, game_id, name: ref(:persister, game_id))
  end
end

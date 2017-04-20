defmodule Werewolf.Gameplay.Persister do
  use Supervisor
  alias Werewolf.{Gameplay}

  def init(game_id) do
    IO.inspect(game_id)
    tid = :ets.new(game_id, [:set])
    IO.inspect(tid)
    children = [
      worker(Gameplay, [[game_id, tid]], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
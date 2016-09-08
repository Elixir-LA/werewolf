defmodule Werewolf.Players.Supervisor do
  use Supervisor
  import Supervisor.Spec
  alias Werewolf.Players.Player

  def start_link, do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__ )
  def init(_ok) do
    children = [
      worker(Player, [], restart: :transient)
    ]
    supervise(children, strategy: :simple_one_for_one)
  end

  def add_player(name) do
    Supervisor.start_child(__MODULE__, [name])
  end
end

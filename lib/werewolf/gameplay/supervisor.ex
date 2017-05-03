defmodule Werewolf.Gameplay.Supervisor do
  use Supervisor
  alias Werewolf.Gameplay.{Persister}

  def start_link, do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok) do
    children = [
      worker(Persister, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

  def create_game(id) do
    {_, persister} = Supervisor.start_child(__MODULE__, [id])
    [ game_pid | other_children ] = Supervisor.which_children(persister)
    game_pid
  end

  def current_games do
    __MODULE__
    |> Supervisor.which_children
    |> Enum.map(&Supervisor.which_children/1)
    |> List.flatten
    |> Enum.map(&game_data/1)
  end

  defp game_data({_id, pid, _type, _modules}) do
    pid
    |> GenServer.call(:get_data)
    |> Map.take([:players])
  end
end

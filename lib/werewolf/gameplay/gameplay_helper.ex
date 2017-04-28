defmodule Werewolf.GameplayHelper do
  def ref(game_id), do: {:global, {:gameplay, game_id}}
end

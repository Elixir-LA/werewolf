defmodule Werewolf.GameplayHelper do
  def ref(category, game_id), do: {:global, {category, game_id}}
end

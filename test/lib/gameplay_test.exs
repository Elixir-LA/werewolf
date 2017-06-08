defmodule Werewolf.GameplayTest do
  use ExUnit.Case, async: true
  alias Werewolf.Gameplay

  test "joining a game that does not exist" do
    fake_pid = :c.pid(0,100,0)
    assert {:error, "Game does not exist"} = Gameplay.join("game-1", "hubert", fake_pid)
  end
end

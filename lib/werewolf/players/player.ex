defmodule Werewolf.Players.Player do
  use GenServer

  def new_player(name) do
    GenServer.start_link(__MODULE__, %{name: name, living: true, role: nil})
  end

  def assign_role(pid, role) do
    GenServer.call(pid, {:role, role})
  end

  def assign_fate(pid, is_living) do
    GenServer.call(pid, {:accept_fate, is_living})
  end

  def handle_call({:role, role}, _from, state) do
    {:reply, :ok, %{state | role: role}}
  end

  def handle_call({:accept_fate, is_living}, _from, state) do
    {:reply, :ok, %{state | living: is_living}}
  end

end

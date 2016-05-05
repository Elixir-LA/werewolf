ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Werewolf.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Werewolf.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Werewolf.Repo)


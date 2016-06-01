use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :werewolf, Werewolf.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :werewolf, Werewolf.Repo,
  adapter: Ecto.Adapters.Postgres,
	url: System.get_env("DATABASE_URL"),
  database: "werewolf_prod",
  size: 20 # The amount of database connections in the pool

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :werewolf, Werewolf.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :werewolf, Werewolf.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "werewolf_test",
  hostname: "localhost",
  port: System.get_env("PGPORT") || 5432,
  pool: Ecto.Adapters.SQL.Sandbox

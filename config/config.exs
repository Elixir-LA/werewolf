# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :werewolf, Werewolf.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hnv4bZ9fiX4/3O5VWpEe8EjaZWSrFXUtCW6LhrXl626bAo0rBSwiBTkMHho7vOPY",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Werewolf.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :werewolf,
  ecto_repos: [Werewolf.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :moments,
  ecto_repos: [Moments.Repo]

# Configures the endpoint
config :moments, MomentsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9dPkMtbGzMffXTk0MgRvqSTNrOeaq9vpnolz4xq5flJzG8NcAVMmkxoRo+3biT/6",
  render_errors: [view: MomentsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Moments.PubSub,
  live_view: [signing_salt: "SnAW56Gi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

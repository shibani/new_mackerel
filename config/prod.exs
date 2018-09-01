# Finally import the config/prod.secret.exs
# which should be versioned separately.
# import_config "prod.secret.exs"

config :yelp, YelpWeb.Endpoint,
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  server: true

config :yelp, Yelp.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: true,
  pool_size: 1 # Free tier db only allows 1 connection

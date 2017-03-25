use Mix.Config

config :stripe_callbacks, StripeCallbacks.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "callbacks_#{Mix.env}",
  username: "postgres",
  password: "",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox]

config :logger,
  backends: [:console],
  level: :warn,
  compile_time_purge_level: :info
use Mix.Config

config :stripe_callbacks, StripeCallbacks.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "stripe_callbacks_#{Mix.env}",
  username: "postgres",
  password: "",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox]

config :stripe_post,
  secret_key: "sk_test_abc123",
  public_key: "pk_test_def456"

config :logger,
  backends: [:console],
  level: :warn,
  compile_time_purge_level: :info
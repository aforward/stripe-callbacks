use Mix.Config

config :stripe_callbacks, StripeCallbacks.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "stripe_callbacks_#{Mix.env}",
  username: "postgres",
  password: "",
  hostname: "localhost",
]
use Mix.Config

config :stripe_callbacks, ecto_repos: [StripeCallbacks.Repo]

if Mix.env == :dev do
  config :mix_test_watch,
    setup_tasks: [
      "ecto.drop --quiet",
      "ecto.create --quiet",
      "ecto.migrate",
    ],
    ansi_enabled: :ignore,
    clear: true
end

if (File.exists?("./config/#{Mix.env}.exs")) do
  import_config "#{Mix.env}.exs"
end

if (File.exists?("./config/#{Mix.env}.priv.exs")) do
  import_config "#{Mix.env}.priv.exs"
end

use Mix.Config

config :stripe_callbacks, ecto_repos: [StripeCallbacks.Repo]

if (File.exists?("./config/#{Mix.env}.exs")) do
  import_config "#{Mix.env}.exs"
end

if (File.exists?("./config/#{Mix.env}.priv.exs")) do
  import_config "#{Mix.env}.priv.exs"
end

defmodule StripeCallbacks.Mixfile do
  use Mix.Project

  @git_url "https://github.com/aforward/stripe-callbacks"
  @home_url @git_url
  @version "0.4.0"

  def project do
    [app: :stripe_callbacks,
     version: @version,
     elixir: "~> 1.4",
     name: "StripeCallbacks",
     description: "A mechanism to post and store Stripe callbacks.",
     package: package(),
     source_url: @git_url,
     homepage_url: @home_url,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {StripeCallbacks.Application, []}]
  end

  def aliases() do
    ["test.once": ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate", "test"]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:mix_test_watch, github: "aforward/mix-test.watch", only: :dev, runtime: false},
     {:postgrex, "~> 0.13.2"},
     {:ecto, "~> 2.1"},
     {:poison, "~> 3.1.0"},
     {:stripe_post, "~> 0.3.0"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [name: :stripe_callbacks,
     files: ["lib", "priv", "mix.exs", "README*", "README*", "LICENSE*"],
     maintainers: ["Andrew Forward"],
     licenses: ["MIT"],
     links: %{"GitHub" => @git_url}]
  end
end

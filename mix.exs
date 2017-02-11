defmodule TubEx.Mixfile do
  use Mix.Project

  @description "Elixir wrapper of YouTube Data API v3"

  def project do
    [app: :tub_ex,
     version: "0.0.11",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: @description,
     package: package,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  defp package do
    [maintainers: ["Takuma Yoshida", "Rastopyr"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/rastopyr/tub_ex"},
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 3.1.0"},
      {:httpoison, "~> 0.8.0"},
      {:ex_doc, "~> 0.14.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:exvcr, ">= 0.0.0", only: :test},
      {:excoveralls, "~> 0.5", only: :test}
    ]
  end
end

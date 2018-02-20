defmodule Tubex.Mixfile do
  use Mix.Project

  @description "Elixir wrapper of YouTube Data API v3"

  def project do
    [app: :tubex,
     version: "0.0.7",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: @description,
     package: package()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  defp package do
    [maintainers: ["Takuma Yoshida"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/yoavlt/tubex"},
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
      {:poison, "~> 3.0"},
      {:httpoison, "~> 0.11.1"},
      {:ex_doc, "~> 0.8.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev}
    ]
  end
end

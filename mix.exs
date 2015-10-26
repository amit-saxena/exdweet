defmodule ExDweet.Mixfile do
  use Mix.Project

  def project do
    [app: :exdweet,
     version: "0.0.1",
     elixir: "~> 1.0",
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  #def application do
  #  [applications: [:httpoison]]
  #end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:httpoison, "~> 0.7.4"},
     {:poison, "~> 1.5"},
    ]
  end

  defp package do
  [ contributors: ["Amit Saxena"],
    licenses: ["MIT"],
    links: %{"Github" => "https://github.com/amit-saxena/exdweet"}
  ]
  end
end

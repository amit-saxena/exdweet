defmodule ExDweet.Mixfile do
  use Mix.Project

  def project do
    [app: :exdweet,
     version: "0.1.0",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [mod: {ExDweet.Supervisor, []}]
  end

  defp deps do
    [{:httpoison, "~> 0.7.4"},
     {:poison, "~> 1.5"},
    ]
  end

  defp description do
    """
    Elixir/Erlang Client for Dweet
    """
  end

  defp package do
  [ maintainers: ["Amit Saxena"],
    licenses: ["MIT"],
    links: %{"Github" => "https://github.com/amit-saxena/exdweet"}
  ]
  end
end

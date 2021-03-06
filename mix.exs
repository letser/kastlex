defmodule Kastlex.Mixfile do
  use Mix.Project

  def project do
    [app: :kastlex,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [mod: {Kastlex, []},
     applications: [:logger, :phoenix, :cowboy, :gettext,
                    :erlzk, :brod, :guardian, :ssl]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:brod, github: "klarna/brod", branch: "2.2-dev"},
     {:exrm, "~> 1.0"},
     {:guardian, "~> 0.12.0"},
     {:erlzk, "~> 0.6.3"}
    ]
  end

end

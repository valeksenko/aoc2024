defmodule Aoc2024.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc2024,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:nimble_parsec, "~> 1.2.3"},
      {:eastar, "~> 0.5.1"},
      {:heap, "~> 3.0.0"},
      {:memoize, "~> 1.4"}
    ]
  end
end

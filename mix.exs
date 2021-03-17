defmodule KafkaHelper.MixProject do
  use Mix.Project

  def project do
    [
      app: :kafka_helper,
      version: "0.2.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
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
      {:msgpax, "~> 2.0"},
      {:msgpax_helper, github: "aisrael/msgpax_helper", tag: "0.2"},
      {:kafka_ex, "~> 0.11"},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:mox, "~> 0.5", only: :test}
    ]
  end
end

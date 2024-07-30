defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.15",
      source_url: "https://github.com/lord-cosmos/issues",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.19"},
      {:earmark, "~> 1.2.4"},
      {:stream_data, ">= 0.0.0"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end

  defp escript_config() do
    [
      main_module: Issues.CLI
    ]
  end
end

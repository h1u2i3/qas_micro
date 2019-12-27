defmodule QasMicro.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :qas_micro,
      version: append_revision(@version),
      elixir: "~> 1.8",
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
      {:jason, "~> 1.1"},
      {:inflex, "~> 2.0"},
      {:yacto, github: "gumi/yacto"},
      {:plug_cowboy, "~> 2.0"},
      {:geo_postgis, "~> 3.1"},
      {:grpc, github: "elixir-grpc/grpc"},

      # deps fix
      {:cowboy, "~> 2.7.0"},
      {:gun, "~> 2.0.0", hex: :grpc_gun},
      {:cowlib, "~> 2.8.0", hex: :grpc_cowlib, override: true}
    ]
  end

  defp append_revision(version) do
    "#{version}+#{revision()}"
  end

  defp revision() do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.trim_trailing()
  end
end

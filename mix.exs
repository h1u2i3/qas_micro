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
      extra_applications: [:logger],
      mod: {QasMicro.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
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

defmodule TinyEvm.MixProject do
  use Mix.Project

  def project do
    [
      app: :tiny_evm,
      version: "0.1.0",
      elixir: "~> 1.6",
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
      {:poison, "~> 3.1"},
      {:merkle_patricia_tree, "~> 0.2.7"}
    ]
  end
end

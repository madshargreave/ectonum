defmodule Ectonum.Mixfile do
  use Mix.Project

  @version "1.0.1"

  def project do
    [app: :ectonum,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     description: description(),
     source_url: "https://github.com/madshargreave/ectonum"]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ecto, "~> 2.1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
    ]
  end

  defp description do
    """
    Adds Ecto custom type for enums
    """
  end

  defp package do
    [
      maintainers: ["Mads Hargreave"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/madshargreave/ectonum"}
    ]
  end

end

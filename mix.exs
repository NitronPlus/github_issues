defmodule GitHub.Issues.Mixfile do
  use Mix.Project

  def project do
    [
      app: :github_issues,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      name: "GitHub Issues",
      source_url: "https://github.com/RaymondLoranger/github_issues",
      description: description(),
      package: package(),
      aliases: aliases(),
      escript: escript_config(),
      deps: deps()
    ]
  end

  defp description do
    """
    Prints GitHub Issues to STDOUT in a table with borders and colors.
    """
  end

  def package do
    [
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/RaymondLoranger/github_issues"
      }
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :httpoison, :jsx]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:io_ansi_table, "~> 0.1", app: false},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:httpoison, "~> 0.11"},
      {:jsx, "~> 2.0"},
      # {:dialyxir, "~> 0.4", only: :dev, runtime: false}
      # {:dialyxir, "== 0.4.3", only: :dev, runtime: false}
      {:dialyxir, "== 0.4.4", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [docs: ["docs", &copy_images/1]]
  end

  defp copy_images(_) do
    File.cp_r "images", "doc/images", fn src, dst ->
      IO.gets(~s|Overwriting "#{dst}" with "#{src}".\nProceed? [Yn]\s|)
      in ["y\n", "Y\n"]
    end
  end

  defp escript_config do
    [
      main_module: GitHub.Issues.CLI,
      name: :gi
    ]
  end
end

defmodule Sphero.Mixfile do
  use Mix.Project

  def project do
    [ app: :sphero,
      version: "0.0.1",
      elixir: "~> 0.11.3-dev",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Sphero, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:exactor, github: "sasa1977/exactor"},
      {:"erlang-serial", github: "knewter/erlang-serial"}
    ]
  end
end

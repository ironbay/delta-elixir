defmodule Delta.Mixfile do
	use Mix.Project

	def project do
		[app: :delta,
		version: "0.1.0",
		elixir: "~> 1.4",
		build_embedded: Mix.env == :prod,
		start_permanent: Mix.env == :prod,
		deps: deps()]
	end

	# Configuration for the OTP application
	#
	# Type "mix help compile.app" for more information
	def application do
		[
			extra_applications: [:logger],
		]
	end

	# Dependencies can be Hex packages:
	#
	#   {:mydep, "~> 0.3.0"}
	#
	# Or git/path repositories:
	#
	#   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
	#
	# Type "mix help deps" for more examples and options
	defp deps do
		[
			{:distillery, "~> 1.0"},
			{:poolboy, "~> 1.5"},
			{:poison, "~> 2.0"},
			{:parallel_stream, "~> 1.0.5"},
			{:credo, "~> 0.5", only: [:dev, :test]},
			{:socket, "~> 0.3.5"},
			# Stores
			{:cqex, "~> 0.2.0"},
 			{:cqerl, github: "matehat/cqerl"},
			{:postgrex, "~> 1.0.0-rc.1"},
			{:mariaex, "~> 0.8.1"},
		]
	end
end

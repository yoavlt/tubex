# Tubex

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add tubex to your list of dependencies in `mix.exs`:

        def deps do
          [{:tubex, "~> 0.0.1"}]
        end

  2. Ensure tubex is started before your application:

        def application do
          [applications: [:tubex]]
        end

  3. Put your config YouTube Data API Key

```elixir
config :tubex, Tubex,
  api_key: "< Your API Key >"
```


## Usage

```elixir
Tubex.Video.search_by_query("Cooking")
```

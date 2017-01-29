# Tubex
---
[![Build Status](https://travis-ci.org/Rastopyr/tubex.svg?branch=master)](https://travis-ci.org/Rastopyr/tubex)
[![Coverage Status](https://coveralls.io/repos/github/Rastopyr/tubex/badge.svg?branch=master)](https://coveralls.io/github/Rastopyr/tubex?branch=master)

Lightweight YouTube v3 API Wrapper
[Documentation](https://hexdocs.pm/tubex)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add tubex to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:tubex, "~> 0.0.10"}]
end
```

2. Ensure tubex is started before your application:

```elixir
def application do
  [applications: [:tubex]]
end
```

  3. Put your config YouTube Data API Key

```elixir
config :tubex, Tubex,
  api_key: "< Your API Key >"
```

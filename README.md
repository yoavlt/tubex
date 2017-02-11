# TubEx
---
[![Build Status](https://travis-ci.org/Rastopyr/tub_ex.svg?branch=master)](https://travis-ci.org/Rastopyr/tub_ex)
[![Coverage Status](https://coveralls.io/repos/github/Rastopyr/tub_ex/badge.svg?branch=master)](https://coveralls.io/github/Rastopyr/tub_ex?branch=master)

Lightweight YouTube v3 API Wrapper
[Documentation](https://hexdocs.pm/tub_ex)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add tub_ex to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:tub_ex, "~> 0.0.11"}]
end
```

2. Ensure tub_ex is started before your application:

```elixir
def application do
  [applications: [:tub_ex]]
end
```

  3. Put your config YouTube Data API Key

```elixir
config :tub_ex, TubEx,
  api_key: "< Your API Key >"
```

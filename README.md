# Tubex
---
[![Build Status](https://travis-ci.org/Rastopyr/tubex.svg?branch=master)](https://travis-ci.org/Rastopyr/tubex)
[![Coverage Status](https://coveralls.io/repos/github/Rastopyr/tubex/badge.svg?branch=master)](https://coveralls.io/github/Rastopyr/tubex?branch=master)

Lightweight YouTube v3 API Wrapper

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

## Usage

### Get detailed videos by id

Sample of usage:
```elixir
Tubex.Video.detail("_J4QPz52Sfo")
```
Sample of response:
```elixir
%{
  "etag" => "\"gMxXHe-zinKdE9lTnzKu8vjcmDI/JFdyorrPQSex3qroXOVBgEtnwvE\"",
  "items" => [
    %{
      "contentDetails" => %{
        "caption" => "false",
        "definition" => "hd",
        "dimension" => "2d",
        "duration" => "PT1H27M27S",
        "licensedContent" => true,
        "projection" => "rectangular"
      },
     "etag" => "\"gMxXHe-zinKdE9lTnzKu8vjcmDI/fEde-ty4hY8_RcD3Blotm0JCmzM\"",
     "id" => "_J4QPz52Sfo",
     "kind" => "youtube#video"
    }
  ],
  "kind" => "youtube#videoListResponse",
  "pageInfo" => %{
    "resultsPerPage" => 1,
    "totalResults" => 1
  }
}
```

### Search by query term
Sample of usage:
```elixir
Tubex.Video.search_by_query("the great debate: the storytelling of science")
```

Sample of response:
```elixir
{
  :ok,
  [
    %Tubex.Video{
      channel_id: "UC4FEqsH9iegAzPJLno5sutg",
      channel_title: "Science and Scholastic",
      description: "Click here to enjoy more videos: http://documentary.googleusd.com Lawrence Krauss speaks at the ASU Origins Project: Storytelling Of Science talk which also ...",
      etag: nil,
      published_at: "2015-07-26T10:07:54.000Z",
      thumbnails: %{
        "default" => %{
          "height" => 90,
          "url" => "https://i.ytimg.com/vi/6ZOudWi6MkI/default.jpg",
          "width" => 120
        },
        "high" => %{
          "height" => 360,
          "url" => "https://i.ytimg.com/vi/6ZOudWi6MkI/hqdefault.jpg",
          "width" => 480
        },
        "medium" => %{
          "height" => 180,
          "url" => "https://i.ytimg.com/vi/6ZOudWi6MkI/mqdefault.jpg",
          "width" => 320
        }
      },
      title: "Storytelling Of Science: Lawrence Krauss",
      video_id: "6ZOudWi6MkI"},
    # ...
  ],
  %{
    "nextPageToken" => "CBQQAA",
    "prevPageToken" => nil,
    "resultsPerPage" => 20,
    "totalResults" => 1000000
  }
}
```

### Get related video by id
Sample request:
```elixir
Tubex.Video.related_with_video("_J4QPz52Sfo")
```

Sample response:
```elixir
{
  :ok,
  [
    %Tubex.Video{
      channel_id: "UC4FEqsH9iegAzPJLno5sutg",
      channel_title: "Science and Scholastic",
      description: "Click here to enjoy more videos: http://documentary.googleusd.com Lawrence Krauss speaks at the ASU Origins Project: Storytelling Of Science talk which also ...",
      etag: nil,
      published_at: "2015-07-26T10:07:54.000Z",
      thumbnails: %{
        "default" => %{
          "height" => 90,
          "url" => "https://i.ytimg.com/vi/6ZOudWi6MkI/default.jpg",
          "width" => 120
        },
        "high" => %{
          "height" => 360,
          "url" => "https://i.ytimg.com/vi/6ZOudWi6MkI/hqdefault.jpg",
          "width" => 480
        },
        "medium" => %{
          "height" => 180,
          "url" => "https://i.ytimg.com/vi/6ZOudWi6MkI/mqdefault.jpg",
          "width" => 320
        }
      },
      title: "Storytelling Of Science: Lawrence Krauss",
      video_id: "6ZOudWi6MkI"},
    # ...
  ],
  %{
    "nextPageToken" => "CBQQAA",
    "prevPageToken" => nil,
    "resultsPerPage" => 20,
    "totalResults" => 1000000
  }
}
```

defmodule TubEx.Video do
  @moduledoc """
    Provide access to the `/videos` are of YouTube API
  """

  @typedoc """
    Type that represents TubEx.Video struct.
  """
  @type t :: %TubEx.Video{
    title: charlist,
    etag: charlist,
    video_id: charlist,
    channel_id: charlist,
    channel_title: charlist,
    description: charlist,
    published_at: charlist,
    thumbnails: charlist,
  }
  defstruct [
    title: nil,
    etag: nil,
    video_id: nil,
    channel_id: nil,
    channel_title: nil,
    description: nil,
    published_at: nil,
    thumbnails: []
  ]

  @doc """
    Fetch contents details

    Example:
      iex> TubEx.Video.get("_J4QPz52Sfo")
      { :ok, %TubEx.Video{} }
  """
  @spec get(charlist) :: { atom, TubEx.Video.t  }
  def get(video_id) do
    opts = [
      key: TubEx.api_key,
      id: video_id,
      part: "snippet",
    ]

    case api_request("/videos", opts) do
      {:ok, %{ "items" => [ item ] } } ->
        parse %{ "snippet" => item, "id" => %{ "videoId" => video_id } }
      err -> err
    end
  end

  @doc """
  Search from youtube via query.

  ## Examples

    ** Get videos by query: **
      iex> TubEx.Video.search("The great debates")
      { :ok, [%TubEx.Video{}, ...], meta_map }

    ** Custom query parameters: **
      iex> TubEx.Video.search("The great debates", [
        paramKey: paramValue,
        ...
      ])
      { :ok, [%TubEx.Video{}, ...], meta_map }
  """
  @spec search(charlist, Keyword.t) :: { atom, list(TubEx.Video.t), map }
  def search(query, opts \\ []) do
    defaults = [
      key: TubEx.api_key,
      part: "snippet",
      maxResults: 20,
      q: query
    ]

    response = api_request("/search", Keyword.merge(defaults, opts))

    case response do
      {:ok, response} ->
        {:ok, Enum.map(response["items"], &parse!/1), page_info(response)}
      err -> err
    end
  end

  @doc """
  Returns a list of videos that match the API request parameters.

  ## Examples

    ** Get related videos: **
      iex> TubEx.Video.related("_J4QPz52Sfo")
      { :ok, [%TubEx.Video{}, ...], meta_map }

    ** Custom query parameters: **
      iex> TubEx.Video.related("_J4QPz52Sfo", [
        paramKey: paramValue,
        ...
      ])
      { :ok, [%TubEx.Video{}], meta_map }
  """
  @spec related(charlist, Keyword.t) :: { atom, list(TubEx.Video.t), map }
  def related(video_id, opts \\ []) do
    defaults = [
      key: TubEx.api_key,
      part: "snippet",
      maxResults: 20,
      relatedToVideoId: video_id
    ]

    response = api_request("/search", Keyword.merge(defaults, opts))

    case response do
      { :ok, response } ->
        {:ok, Enum.map(response["items"], &parse!/1), page_info(response)}
      err -> err
    end
  end

  defp api_request(pathname, query) do
    TubEx.API.get(
      TubEx.endpoint <> pathname,
      Keyword.merge(query, [type: "video"])
    )
  end

  defp page_info(response) do
    Map.merge(response["pageInfo"], %{
      "nextPageToken" => response["nextPageToken"],
      "prevPageToken" => response["prevPageToken"]
    })
  end

  defp parse!(body) do
    case parse(body) do
      {:ok, video} -> video
      {:error, body} ->
        raise "Parse error occured! #{Poison.Encoder.encode(body, %{})}"
    end
  end

  defp parse(%{"snippet" => snippet, "id" => %{"videoId" => video_id}}) do
    {:ok,
      %TubEx.Video{
        etag: snippet["etag"],
        title: snippet["title"],
        thumbnails: snippet["thumbnails"],
        published_at: snippet["publishedAt"],
        channel_title: snippet["channelTitle"],
        channel_id: snippet["channelId"],
        description: snippet["description"],
        video_id: video_id
      }
    }
  end

  defp parse(body) do
    {:error, body}
  end
end

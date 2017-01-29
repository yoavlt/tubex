defmodule Tubex.Video do
  @moduledoc """
    Provide access to the `/videos` are of YouTube API
  """

  @typedoc """
    Type that represents Tubex.Video struct.
  """
  @type t :: %Tubex.Video{
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
      iex> Tubex.Video.detail("_J4QPz52Sfo")
      { :ok, %Tubex.Video{} }
  """
  @spec detail(charlist) :: { atom, Tubex.Video.t  }
  def detail(video_id) do
    opts = [
      key: Tubex.api_key,
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
      iex> Tubex.Video.search_by_query("_J4QPz52Sfo")
      { :ok, [%Tubex.Video{}, ...], meta_map }

    ** Custom query parameters: **
      iex> Tubex.Video.search_by_query("_J4QPz52Sfo", [
        paramKey: paramValue,
        ...
      ])
      { :ok, [%Tubex.Video{}, ...], meta_map }
  """
  @spec search_by_query(charlist, Keyword.t) :: { atom, list(Tubex.Video.t), map }
  def search_by_query(query, opts \\ []) do
    defaults = [
      key: Tubex.api_key,
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
      iex> Tubex.Video.related_with_video("_J4QPz52Sfo")
      { :ok, [%Tubex.Video{}, ...], meta_map }

    ** Custom query parameters: **
      iex> Tubex.Video.related_with_video("_J4QPz52Sfo", [
        paramKey: paramValue,
        ...
      ])
      { :ok, [%Tubex.Video{}], meta_map }
  """
  @spec related_with_video(charlist, Keyword.t) :: { atom, list(Tubex.Video.t), map }
  def related_with_video(video_id, opts \\ []) do
    defaults = [
      key: Tubex.api_key,
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
    Tubex.API.get(
      Tubex.endpoint <> pathname,
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
      %Tubex.Video{
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

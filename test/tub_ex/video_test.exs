defmodule TubExTest.Video do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @videoId "_J4QPz52Sfo"
  @key System.get_env("YOUTUBE_API_KEY")
  @q "the great debate: the storytelling of science"

  defp video_type_spec(%TubEx.Video{}), do: true
  defp video_type_spec(_), do: false

  defp now, do: DateTime.to_unix(DateTime.utc_now())

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "video detail" do
    use_cassette "get_video" do
      HTTPoison.start
      {:ok, resp} = HTTPoison.get("#{TubEx.endpoint}/videos?id=#{@videoId}&key=#{@key}&part=snippet", [])
      %{ body: body, status_code: status } = resp;
      %{ "items" => [ item ] } = Poison.decode!(body)
      { :ok, video } = TubEx.Video.get(@videoId);

      expected = %TubEx.Video{
        etag: item["etag"],
        title: item["title"],
        thumbnails: item["thumbnails"],
        published_at: item["publishedAt"],
        channel_title: item["channelTitle"],
        channel_id: item["channelId"],
        description: item["description"],
        video_id: @videoId
      }

      assert status == 200
      assert video_type_spec video
      assert expected == video
    end
  end

  test "negative detail" do
    use_cassette "negative_detail" do
      HTTPoison.start
      { :error, %{ "error" => %{ "code" => code } } } = TubEx.Video.get("#{now}")
      assert code == 400
    end
  end

  test "search_by_query" do
    use_cassette "search_by_query" do
      HTTPoison.start
      query = TubEx.Utils.encode_body([
        key: @key,
        part: "snippet",
        maxResults: 20,
        type: "video",
        q: @q
      ])
      {:ok, resp} = HTTPoison.get("#{TubEx.endpoint}/search?#{query}", [])
      %{ body: body, status_code: status } = resp;
      response = Poison.decode!(body)

      { :ok, videos, page_info } = TubEx.Video.search(@q)

      assert status == 200
      assert page_info["nextPageToken"] == response["nextPageToken"]
      assert page_info["prevPageToken"] == response["prevPageToken"]
      assert length(videos) === 20
      assert Enum.all?(videos, fn video -> video_type_spec(video) end)
    end
  end

  test "negative search_by_query" do
    use_cassette "negative_search_by_query" do
      HTTPoison.start
      query = [
        part: "123123"
      ]

      { :error, %{ "error" => %{ "code" => code } } } = TubEx.Video.search(@q, query)

      assert code == 400
    end
  end

  test "related_videos" do
    use_cassette "related_videos" do
      HTTPoison.start
      {:ok, resp} = HTTPoison.get("#{TubEx.endpoint}/search?relatedToVideoId=#{@videoId}&key=#{@key}&part=snippet&maxResults=20&type=video", [])
      %{ body: body, status_code: status } = resp;
      response = Poison.decode!(body)

      { :ok, videos, page_info } = TubEx.Video.related(@videoId)

      assert status == 200
      assert page_info["nextPageToken"] == response["nextPageToken"]
      assert page_info["prevPageToken"] == response["prevPageToken"]
      assert length(videos) === 20
      assert Enum.all?(videos, fn video -> video_type_spec(video) end)
    end
  end

  test "negative related_videos" do
    use_cassette "negative_related_videos" do
      HTTPoison.start
      query = [
        part: "123123"
      ]

      { :error, %{ "error" => %{ "code" => code } } } = TubEx.Video.related(@videoId, query)

      assert code == 400
    end
  end

  test "raise parse" do
    use_cassette "raise_parse" do
      HTTPoison.start

      assert_raise RuntimeError, fn -> TubEx.Video.search("#{now()}") end
    end
  end
end

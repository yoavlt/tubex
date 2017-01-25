defmodule TubexTest.Video do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @videoId "_J4QPz52Sfo"
  @key System.get_env("YOUTUBE_API_KEY")
  @q "The%20Great%20Debate%3A%20THE%20STORYTELLING%20OF%20SCIENCE%20%28OFFICIAL%29"

  def video_type_spec(%Tubex.Video{}), do: true

  def video_type_spec(_), do: false

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "video detail" do
    use_cassette "get_video" do
      HTTPoison.start
      {:ok, resp} = HTTPoison.get("#{Tubex.endpoint}/videos?id=#{@videoId}&key=#{@key}&part=contentDetails", [])
      %{ body: body, status_code: status } = resp;
      assert status == 200
      assert Poison.decode!(body) == Tubex.Video.detail(@videoId)
    end
  end

  test "search_by_query" do
    use_cassette "search_by_query" do
      HTTPoison.start
      {:ok, resp} = HTTPoison.get("#{Tubex.endpoint}/search?q=#{@q}&key=#{@key}&type=video&part=snippet&maxResults=20", [])
      %{ body: body, status_code: status } = resp;
      response = Poison.decode!(body)

      { :ok, videos, page_info } = Tubex.Video.search_by_query(@q)

      assert status == 200
      assert page_info["nextPageToken"] == response["nextPageToken"]
      assert page_info["prevPageToken"] == response["prevPageToken"]
      assert length(videos) === 20
      assert Enum.all?(videos, fn video -> video_type_spec(video) end)
    end
  end

  test "related_videos" do
    use_cassette "related_videos" do
      HTTPoison.start
      {:ok, resp} = HTTPoison.get("#{Tubex.endpoint}/search?relatedToVideoId=#{@videoId}&key=#{@key}&part=snippet&maxResults=20&type=video", [])
      %{ body: body, status_code: status } = resp;
      response = Poison.decode!(body)

      { :ok, videos, page_info } = Tubex.Video.search_by_query(@q)

      assert status == 200
      assert page_info["nextPageToken"] == response["nextPageToken"]
      assert page_info["prevPageToken"] == response["prevPageToken"]
      assert length(videos) === 20
      assert Enum.all?(videos, fn video -> video_type_spec(video) end)
    end
  end
end

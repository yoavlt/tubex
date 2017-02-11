defmodule TubEx do

  def endpoint, do: "https://www.googleapis.com/youtube/v3"

  defp config do
    Application.get_env(:tub_ex, TubEx)
  end

  def api_key do
    config()[:api_key] ||
      System.get_env("YOUTUBE_API_KEY")
  end
end

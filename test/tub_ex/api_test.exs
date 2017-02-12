defmodule TubExTest.API do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  ###
  # NOTE:
  # This is stubbed tests for improved test coverage, and probably regression
  ###

  test "api post" do
    use_cassette "api_post" do
      TubEx.API.post(
        TubEx.endpoint <> "/videos",
        %{}
      )
    end
  end

  test "api delete" do
    use_cassette "api_delete" do
      TubEx.API.delete(
        TubEx.endpoint <> "/videos"
      )
    end
  end
end

defmodule TubEx.API do
  def get(url, query \\ []) do
    HTTPoison.start
    query = TubEx.Utils.encode_body(query)

    url = unless String.length(query) == 0 do
      "#{url}?#{query}"
    end

    HTTPoison.get!(url, [])
    |> handle_response
  end

  def post(url, body) do
    HTTPoison.start

    req_body = Poison.encode!(body)

    HTTPoison.post!(url, req_body, [])
    |> handle_response
  end

  def delete(url) do
    HTTPoison.start
    HTTPoison.delete!(url, [])
    |> handle_response
  end

  defp handle_response(%HTTPoison.Response{body: body, status_code: code}) when code in 200..299 do
    {:ok, Poison.decode!(body)}
  end

  defp handle_response(%HTTPoison.Response{body: body, status_code: _}) do
    {:error, Poison.decode!(body)}
  end
end

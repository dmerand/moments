defmodule MomentsWeb.Authentication do
  @doc """
  Check whether a given value is a valid auth token
  """
  def check_token(token) when is_binary(token) do
    Enum.any?(tokens(), &(&1 == token))
  end

  defp tokens do
    case Application.fetch_env(:moments, __MODULE__) do
      {:ok, keywords} -> Keyword.fetch!(keywords, :tokens)
      :error -> []
    end
  end
end

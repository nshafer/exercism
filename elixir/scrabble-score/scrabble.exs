defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.graphemes()
    |> Stream.map(&score_char/1)
    |> Enum.sum()
  end

  defp score_char(char) when char in ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], do: 1
  defp score_char(char) when char in ["D", "G"], do: 2
  defp score_char(char) when char in ["B", "C", "M", "P"], do: 3
  defp score_char(char) when char in ["F", "H", "V", "W", "Y"], do: 4
  defp score_char(char) when char == "K", do: 5
  defp score_char(char) when char in ["J", "X"], do: 8
  defp score_char(char) when char in ["Q", "Z"], do: 10
  defp score_char(_char), do: 0
end

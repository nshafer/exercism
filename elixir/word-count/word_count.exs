defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^[:alnum:]\-]/u, trim: true)
    |> Enum.reduce(%{}, &count_word/2)
  end

  defp count_word(word, counts) do
    Map.update(counts, word, 1, fn count -> count + 1 end)
  end
end

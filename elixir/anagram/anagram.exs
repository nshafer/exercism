defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Stream.filter(fn candidate -> String.downcase(base) != String.downcase(candidate) end)
    |> Stream.filter(fn candidate -> normalize(base) == normalize(candidate) end)
    |> Enum.uniq()
  end

  defp normalize(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end

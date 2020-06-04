defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    result = sentence
    |> String.downcase()
    |> String.replace(~r/[^[:alpha:]]/u, "")
    |> String.graphemes()
    |> Enum.reduce_while(%MapSet{}, &unique_chars?/2)

    result != false
  end

  defp unique_chars?(char, set) do
    case MapSet.member?(set, char) do
      true -> {:halt, false}
      false -> {:cont, MapSet.put(set, char)}
    end
  end
end

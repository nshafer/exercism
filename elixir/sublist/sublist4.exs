defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
     cond do
      is_sublist(a, b) -> :sublist
      is_superlist(a, b) -> :superlist
      a == b -> :equal
      true -> :unequal
     end
  end

  defp is_sublist(a, b) when length(a) < length(b) do
    contained_in_list(a, b)
  end
  defp is_sublist(_, _), do: false

  defp is_superlist(a, b) when length(a) > length(b) do
    contained_in_list(b, a)
  end
  defp is_superlist(_, _), do: false

  defp contained_in_list(x, y) do
    length(y) - length(x)
    |> (fn l -> 0..l end).()
    |> Enum.any?(fn i -> Enum.slice(y, i, length(x)) === x end)
  end
end

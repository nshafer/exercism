defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?([], []), do: true
  defp sublist?([], _b), do: true
  defp sublist?(_a, []), do: false

  defp sublist?([a_hd | _] = a, [b_hd | b_tl] = b) do
    if a_hd === b_hd and contiguous_sublist?(a, b) do
      true
    else
      sublist?(a, b_tl)
    end
  end

  defp contiguous_sublist?([], _b), do: true
  defp contiguous_sublist?(_a, []), do: false

  defp contiguous_sublist?([a_hd | a_tl], [b_hd | b_tl]) do
    if a_hd === b_hd do
      contiguous_sublist?(a_tl, b_tl)
    else
      false
    end
  end
end

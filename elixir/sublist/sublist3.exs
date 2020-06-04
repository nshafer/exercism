defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == [] and b == [] -> :equal
      a == [] -> :sublist
      b == [] -> :superlist
      length(a) == length(b) -> (a == b && :equal) || :unequal
      length(a) > length(b) -> (sublist?(a, b) && :superlist) || :unequal
      length(a) < length(b) -> (sublist?(b, a) && :sublist) || :unequal
      true -> :oops
    end

  end

  def sublist?(max_list, min_list) when length(max_list) >= length(min_list) do
    List.starts_with?(max_list, min_list) || sublist?(tl(max_list), min_list)
  end

  def sublist?(max_list, min_list) when length(max_list) < length(min_list) do
    false
  end


end

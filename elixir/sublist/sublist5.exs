defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
   cond do
    a == b -> :equal
    is_present?(a,b) -> :sublist
    is_present?(b,a) -> :superlist
    true -> :unequal
   end

  end


  defp is_present?(first,second) do
    cont = Enum.count(first)
    cond do
      cont > Enum.count(second) -> false
      Enum.take(second, cont) === first -> true
      true -> [_|b] = second
      is_present?(first, b)
    end
  end


end

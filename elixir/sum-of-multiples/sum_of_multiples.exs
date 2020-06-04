defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Stream.filter(fn num -> is_multiple?(num, factors) end)
    |> Enum.sum()
  end

  defp is_multiple?(num, factors) do
    Enum.any?(factors, fn factor -> rem(num, factor) == 0 end)
  end
end

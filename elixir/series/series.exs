defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size < 1, do: []

  def slices(s, size) do
    if size > String.length(s) do
      []
    else
      slice = String.slice(s, 0, size)
      next = String.slice(s, 1..-1)
      [slice | slices(next, size)]
    end
  end
end

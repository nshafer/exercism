defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    search_at(numbers, key, div(tuple_size(numbers), 2), 0, tuple_size(numbers) - 1)
  end

  # Search at a given index for key, as long as the index is within low/high bounds
  defp search_at(_numbers, _key, i, low, _high) when i < low, do: :not_found
  defp search_at(_numbers, _key, i, _low, high) when i > high, do: :not_found
  defp search_at(numbers, key, i, low, high) do
    case elem(numbers, i) do
      ^key -> {:ok, i}
      n when key < n -> search_left(numbers, key, i, low, high)
      n when key > n -> search_right(numbers, key, i, low, high)
    end
  end

  # Calculate the half-way point between the low bound and the current index
  defp search_left(_numbers, _key, i, low, _high) when i <= low, do: :not_found
  defp search_left(numbers, key, i, low, _high) do
    search_at(numbers, key, low + div(i - low, 2), low, i - 1)
  end

  # Calculate the half-way point between the current index and the high bound
  defp search_right(_numbers, _key, i, _low, high) when i >= high, do: :not_found
  defp search_right(numbers, key, i, _low, high) do
    search_at(numbers, key, high - div(high - i, 2), i + 1, high)
  end
end

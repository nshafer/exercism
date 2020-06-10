defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.reduce(input, %{}, fn {key, list}, map ->
      Enum.reduce(list, map, fn val, map ->
        Map.put(map, String.downcase(val), key)
      end)
    end)
  end

  def transform2(input) do
    for {key, values} <- input, val <- values, into: %{} do
      IO.puts "key: #{inspect key} values: #{inspect values} val: #{inspect val}"
      {String.downcase(val), key}
    end
  end
end

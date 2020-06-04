defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{line_one(number)}
    #{line_two(number)}
    """
  end

  def line_one(0), do: "No more bottles of beer on the wall, no more bottles of beer."
  def line_one(1), do: "1 bottle of beer on the wall, 1 bottle of beer."
  def line_one(n), do: "#{n} bottles of beer on the wall, #{n} bottles of beer."

  def line_two(0), do: "Go to the store and buy some more, 99 bottles of beer on the wall."
  def line_two(1), do: "Take it down and pass it around, no more bottles of beer on the wall."
  def line_two(2), do: "Take one down and pass it around, 1 bottle of beer on the wall."
  def line_two(n), do: "Take one down and pass it around, #{n-1} bottles of beer on the wall."

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map(fn number -> verse(number) end)
    |> Enum.join("\n")
  end
end

defmodule Roman do
  @symbols {
    {"I", "V", "X"},  # Ones place
    {"X", "L", "C"},  # Tens place
    {"C", "D", "M"},  # Hundreds place
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    number
    |> Integer.digits()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {value, place} -> romanize(value, place) end)
    |> Enum.reverse()
    |> List.to_string()
  end

  defp romanize(value, place) when place < 3 do
    minor = @symbols |> elem(place) |> elem(0)
    mezzo = @symbols |> elem(place) |> elem(1)
    major = @symbols |> elem(place) |> elem(2)
    cond do
      value <= 3 -> String.duplicate(minor, value)
      value == 4 -> minor <> mezzo
      value == 5 -> mezzo
      value <= 8 -> mezzo <> String.duplicate(minor, value - 5)
      value == 9 -> minor <> major
    end
  end

  defp romanize(value, place) when place == 3 do
    String.duplicate("M", value)
  end
end

defmodule Say do
  @ones %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen"
  }

  @decs %{
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }

  @mills %{
    1 => "thousand",
    2 => "million",
    3 => "billion",
    4 => "trillion"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(num) when num >= 0 and num <= 999_999_999_999, do: {:ok, parse_number(num)}
  def in_english(_), do: {:error, "number is out of range"}

  defp parse_number(num) when num >= 0 and num <= 19 do
    Map.get(@ones, num)
  end

  defp parse_number(num) when num >= 20 and num <= 99 do
    case rem(num, 10) do
      0 -> Map.get(@decs, div(num, 10))
      n -> "#{Map.get(@decs, div(num, 10))}-#{parse_number(n)}"
    end
  end

  defp parse_number(num) when num >= 100 and num <= 999 do
    case rem(num, 100) do
      0 -> "#{parse_number(div(num, 100))} hundred"
      n -> "#{parse_number(div(num, 100))} hundred #{parse_number(n)}"
    end
  end

  defp parse_number(num) when num >= 1000 do
    split_integer(num)
    |> Enum.reverse()
    |> Stream.with_index()
    |> Stream.filter(fn {n, _} -> n != 0 end)
    |> Stream.map(fn
      {n, i} when i == 0 -> parse_number(n)
      {n, i} -> "#{parse_number(n)} #{Map.get(@mills, i)}"
    end)
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp split_integer(num, acc \\ [])
  defp split_integer(num, acc) when num < 1000, do: [num | acc]
  defp split_integer(num, acc), do: split_integer(div(num, 1000), [rem(num, 1000) | acc])
end

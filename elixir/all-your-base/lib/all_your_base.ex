defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil

  def convert(digits, base_a, base_b) do
    if valid_digits?(digits, base_a) do
      digits
      |> decode(base_a)
      |> encode(base_b)
    end
  end

  defp valid_digits?(digits, base) do
    Enum.all?(digits, fn digit -> digit >= 0 and digit < base end)
  end

  defp decode(digits, base) do
    digits
    |> Enum.reverse()
    |> Stream.with_index()
    |> Enum.reduce(0, fn {digit, i}, acc -> acc + digit * trunc(:math.pow(base, i)) end)
  end

  defp encode(num, base, digits \\ [])
  defp encode(0, _, []), do: [0]
  defp encode(0, _, digits), do: digits
  defp encode(num, base, digits), do: encode(div(num, base), base, [rem(num, base) | digits])
end

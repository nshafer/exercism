defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    with {:ok, isbn} <- normalize(isbn),
         {:ok, digits} <- to_digits(isbn)
    do
      valid?(digits)
    else
      _ -> false
    end
  end

  def normalize(isbn) do
    isbn =
      isbn
      |> String.upcase()
      |> String.replace(~r/-/, "")

    if Regex.match?(~r/^[0-9]{9}[0-9X]$/, isbn) do
      {:ok, isbn}
    else
      :error
    end
  end

  def to_digits(isbn) do
    digits =
      isbn
      |> String.graphemes()
      |> Enum.map(&to_digit/1)

    {:ok, digits}
  end

  defp to_digit("X"), do: 10
  defp to_digit(digit), do: String.to_integer(digit)

  def valid?(digits) do
    sum =
      digits
      |> Enum.zip(10..1)
      |> Enum.map(fn {a, b} -> a * b end)
      |> Enum.sum()

    rem(sum, 11) == 0
  end
end

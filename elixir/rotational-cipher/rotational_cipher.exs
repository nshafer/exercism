defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(fn cp -> rotate_codepoint(cp, shift) end)
    |> to_string()
  end

  def rotate_codepoint(cp, shift) do
    cond do
      cp >= ?a and cp <= ?z -> shift_codepoint(cp, shift, ?a, ?z)
      cp >= ?A and cp <= ?Z -> shift_codepoint(cp, shift, ?A, ?Z)
      true -> cp
    end
  end

  def shift_codepoint(cp, shift, low, high) do
    case cp + shift do
      cp when cp > high -> low + (cp - high - 1)
      cp -> cp
    end
  end
end

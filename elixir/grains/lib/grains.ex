defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(num) when num >= 1 and num <= 64, do: {:ok, pow2(num - 1)}
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  @doc """
  Adds square of each number from 1 to 64
  This is also 2^64-1
  """
  @spec total :: pos_integer
  def total do
    {:ok, pow2(64) - 1}
  end

  # Calculate the result of 2^x
  @spec pow2(pos_integer()) :: pos_integer()
  def pow2(0), do: 1
  def pow2(num), do: 2 * pow2(num - 1)
end

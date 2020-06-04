defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  def nth(count) when count > 0 do
    Stream.iterate(2, fn i -> i + 1 end)
    |> Stream.filter(&is_prime?/1)
    |> Enum.at(count - 1)
  end

  defp is_prime?(2), do: true
  defp is_prime?(n) when rem(n, 2) == 0, do: false

  defp is_prime?(n) do
    2..ceil(:math.sqrt(n))
    |> Enum.all?(fn i -> rem(n, i) != 0 end)
  end
end

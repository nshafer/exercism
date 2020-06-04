defmodule Primes do
  def generate(limit, i \\ 2, acc \\ [])
  def generate(limit, _, acc) when length(acc) >= limit, do: Enum.reverse(acc)

  def generate(limit, i, acc) do
    if is_prime?(i) do
      generate(limit, i + 1, [i | acc])
    else
      generate(limit, i + 1, acc)
    end
  end

  defp is_prime?(2), do: true
  defp is_prime?(n) when rem(n, 2) == 0, do: false

  defp is_prime?(n) do
    2..ceil(:math.sqrt(n))
    |> Enum.all?(fn i -> rem(n, i) != 0 end)
  end
end

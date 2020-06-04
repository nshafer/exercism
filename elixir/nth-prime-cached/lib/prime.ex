defmodule Prime do
  # Cache a short tuple of primes at compile time
  @num_primes 100
  @primes Primes.generate(@num_primes) |> List.to_tuple()

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count >= 1 and count <= @num_primes do
    elem(@primes, count - 1)
  end

  def nth(count) when count > @num_primes do
    count = count - @num_primes
    last_prime = elem(@primes, @num_primes - 1)
    Primes.generate(count, last_prime + 1)
    |> Enum.at(count - 1)
  end
end

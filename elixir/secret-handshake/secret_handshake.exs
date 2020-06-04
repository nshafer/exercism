defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    handshake(code)
  end

  def handshake(code, actions \\ []) do
    cond do
      (code &&& 0b00001) > 0 -> handshake(code - 0b00001, ["wink" | actions])
      (code &&& 0b00010) > 0 -> handshake(code - 0b00010, ["double blink" | actions])
      (code &&& 0b00100) > 0 -> handshake(code - 0b00100, ["close your eyes" | actions])
      (code &&& 0b01000) > 0 -> handshake(code - 0b01000, ["jump" | actions])
      (code &&& 0b10000) > 0 -> handshake(code - 0b10000, Enum.reverse(actions))
      true -> Enum.reverse(actions)
    end
  end
end

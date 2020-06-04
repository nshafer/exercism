defmodule TwelveDays do
  @days {"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth",
         "tenth", "eleventh", "twelfth"}

  @gifts {
    "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{elem(@days, number - 1)} day of Christmas my true love gave to me: #{gifts(number)}"
  end

  def gifts(1), do: elem(@gifts, 0)

  def gifts(number) do
    list_of_gifts =
      (number - 1)..1
      |> Enum.map(fn num -> elem(@gifts, num) end)
      |> Enum.join(", ")

    "#{list_of_gifts}, and #{gifts(1)}"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(fn number -> verse(number) end)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end

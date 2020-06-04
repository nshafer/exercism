defmodule Bob do
  def hey(input) do
    cond do
      shouting?(input) and question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      silence?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  defp silence?(input), do: String.trim(input) == ""
  defp question?(input), do: String.last(input) == "?"
  defp shouting?(input), do: String.upcase(input) == input
    and String.upcase(input) != String.downcase(input)
end

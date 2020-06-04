defmodule BracketPush do
  @lbrackets ~w/[ { (/
  @rbrackets ~w/] } )/

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    String.graphemes(str) |> parse_brackets([])
  end

  defp parse_brackets([], []), do: true
  defp parse_brackets([], _), do: false
  defp parse_brackets([char | chars], stack) when char in @lbrackets,
    do: parse_brackets(chars, [char | stack])
  defp parse_brackets([char | chars], stack) when char in @rbrackets,
    do: check_bracket(char, stack) and parse_brackets(chars, tl(stack))
  defp parse_brackets([_ | chars], stack), do: parse_brackets(chars, stack)

  defp check_bracket(_, []), do: false
  defp check_bracket(bracket, [open | _]) do
    index = Enum.find_index(@lbrackets, fn val -> val == open end)
    bracket == Enum.at(@rbrackets, index)
  end
end

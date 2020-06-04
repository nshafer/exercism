defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  # Refactor: Use more descriptive variable names
  #           Convert to pipes to increase readability of the parsing process
  #           Capture the process function instead of calling it in an anonymous function
  def parse(input) do
    String.split(input, "\n")
    |> Enum.map_join(&process/1)
    |> wrap_unordered_list()
  end

  # Refactor: Break up into pattern-matched functions
  defp process("#" <> _ = line), do: enclose_with_header_tag(line)
  defp process("*" <> _ = line), do: parse_list_md_level(line)
  defp process(line), do: enclose_with_paragraph_tag(line)

  defp parse_header_md_level(line) do
    [h | t] = String.split(line)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  # Refactor: rename variables, use pipes
  defp parse_list_md_level(line) do
    text = line
    |> String.trim_leading("* ")
    |> String.split()
    |> join_words_with_tags()

    "<li>#{text}</li>"
  end

  # Refactor: rename variables, call parse_header_md_level from here, use string interpolation
  defp enclose_with_header_tag(line) do
    {level, text} = parse_header_md_level(line)
    "<h#{level}>#{text}</h#{level}>"
  end

  # Refactor: rename variables, split the line into words in this function, use pipes
  defp enclose_with_paragraph_tag(line) do
    text = line
    |> String.split()
    |> join_words_with_tags()
    "<p>#{text}</p>"
  end

  # Refactor: Use pipes, rename variables, capture function instead of calling in anonymous fn
  defp join_words_with_tags(words) do
    words
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  # Refactor: Use pipes, rename variables
  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  # Refactor: More descriptive name, use pipes, rename variables, remove superfluous concatenation
  defp wrap_unordered_list(line) do
    line
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end

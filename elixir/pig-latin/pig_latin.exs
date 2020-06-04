defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  def translate_word(word) do
    {head, tail} = split_word(word)
    tail <> head <> "ay"
  end

  def split_word(word) do
    char1 = String.slice(word, 0, 1)
    char2 = String.slice(word, 1, 1)
    cond do
      char1 in @vowels -> {"", word}
      char1 in ["y", "x"] and char2 not in @vowels -> {"", word}
      true -> split_consonants(char1, String.slice(word, 1..-1))
    end
  end

  def split_consonants(head, tail) do
    tail_char1 = String.slice(tail, 0, 1)
    cond do
      tail == "" -> {head, ""}
      head == "q" and tail_char1 == "u" -> split_consonants(head <> "u", String.slice(tail, 1..-1))
      String.slice(tail, 0, 2) == "qu" -> split_consonants(head <> "qu", String.slice(tail, 2..-1))
      tail_char1 in @vowels -> {head, tail}
      true -> split_consonants(head <> tail_char1, String.slice(tail, 1..-1))
    end
  end
end

defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(fn str -> str end)
    |> Enum.map(&encode_chunk/1)
    |> List.to_string()
  end

  defp encode_chunk(chunk) do
    len = length(chunk)
    chr = List.first(chunk)
    if len > 1 do
      to_string(len) <> chr
    else
      chr
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/\d*[\w\s]/, string)
    |> Enum.concat()
    |> Enum.map(&decode_chunk/1)
    |> List.to_string()
  end

  defp decode_chunk(chunk) do
    case Integer.parse(chunk) do
      :error -> chunk
      {count, str} -> String.duplicate(str, count)
    end
  end
end

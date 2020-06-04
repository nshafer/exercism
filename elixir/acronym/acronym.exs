defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/[^\w\d\s]/u, "")
    |> String.replace(~r/([A-Z])/, " \\1")
    |> String.split()
    |> Enum.map(fn word -> String.slice(word, 0, 1) end)
    |> Enum.join("")
    |> String.upcase()
  end
end

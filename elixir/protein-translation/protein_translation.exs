defmodule ProteinTranslation do
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    case parse_rna(rna) do
      :error -> {:error, "invalid RNA"}
      proteins -> {:ok, proteins}
    end
  end

  defp parse_rna(rna, proteins \\ [])
  defp parse_rna("", proteins), do: Enum.reverse(proteins)

  defp parse_rna(rna, proteins) do
    {codon, rest} = String.split_at(rna, 3)
    case of_codon(codon) do
      {:error, _} -> :error
      {:ok, "STOP"} -> Enum.reverse(proteins)
      {:ok, protein} -> parse_rna(rest, [protein | proteins])
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codons, codon) do
      {:ok, _} = val -> val
      :error -> {:error, "invalid codon"}
    end
  end
end

defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna
    |> String.to_charlist
    |> Enum.chunk_every(3)
    |> Enum.reduce_while({:ok, []}, &reduce_func/2)
  end

  defp reduce_func(x, {:ok, result}) do
    case of_codon(to_string(x)) do
      {:ok, protein} ->
        if protein == "STOP" do
          {:halt, {:ok, result}}
        else
          {:cont, {:ok, result ++ [protein]}}
        end
      {:error, _} ->
        {:halt, {:error, "invalid RNA"}}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @codon_protein_mapping %{
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
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    result = Map.get(@codon_protein_mapping, codon)
    if result do
      {:ok, result}
    else
      {:error, "invalid codon"}
    end
  end
end


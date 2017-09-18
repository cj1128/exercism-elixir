defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.trim
    |> String.upcase
    |> String.to_charlist
    |> Enum.map(&char_to_score/1)
    |> Enum.sum
  end

  # char should be uppercase
  defp char_to_score(char) when char in 'AEIOULNRST', do: 1
  defp char_to_score(char) when char in 'DG', do: 2
  defp char_to_score(char) when char in 'BCMP', do: 3
  defp char_to_score(char) when char in 'FHVWY', do: 4
  defp char_to_score(char) when char in 'K', do: 5
  defp char_to_score(char) when char in 'JX', do: 8
  defp char_to_score(char) when char in 'QZ', do: 10
  defp char_to_score(_), do: 0
end

defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&is_anagram(base, &1))
  end

  # case insensitive
  defp is_anagram(source, target) do
    source_downcase = String.downcase(source)
    target_downcase = String.downcase(target)
    source_downcase != target_downcase and
    get_sorted_charlist(source_downcase) == get_sorted_charlist(target_downcase)
  end

  defp get_sorted_charlist(str),
    do: str |> String.to_charlist |> Enum.sort
end

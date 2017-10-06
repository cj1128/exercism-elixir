defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    s = String.replace(sentence, ~r/[\W0-9_]+/, "")
    String.length(s) ==
      s
      |> String.to_charlist
      |> Enum.uniq
      |> Enum.count
  end
end

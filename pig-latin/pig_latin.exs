defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]
  @two_chars_vowels ["yt", "xr"]
  @two_chars_consonants ["ch", "qu", "th"]
  @three_chars_consonants ["squ", "thr", "sch", "ch"]
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
    phrase
    |> String.split(" ")
    |> Enum.map(&transform/1)
    |> Enum.join(" ")
  end

  defp transform(""), do: ""
  defp transform(<<x :: binary-size(1)>> <> rest) when x in @vowels do
    x <> rest <> "ay"
  end
  defp transform(<<x :: binary-size(2)>> <> rest) when x in @two_chars_vowels do
    x <> rest <> "ay"
  end
  defp transform(<<x :: binary-size(3)>> <> rest) when x in @three_chars_consonants do
    transform(rest <> x)
  end
  defp transform(<<x :: binary-size(2)>> <> rest) when x in @two_chars_consonants do
    transform(rest <> x)
  end
  defp transform(<<x :: binary-size(1)>> <> rest) do
    transform(rest <> x)
  end
end

defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.graphemes
    |> Enum.chunk_by(&(&1))
    |> Enum.map_join(&list_to_char/1)
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    do_decode(string, "")
  end

  defp do_decode("", result), do: result
  defp do_decode(str, result) do
    case Integer.parse(str) do
      :error ->
        do_decode(String.slice(str, 1..-1), result <> String.at(str, 0))
      {val, <<chr :: binary-size(1) >> <> remainder} ->
        do_decode(remainder, result <> String.duplicate(chr, val))
    end
  end

  defp list_to_char([x]), do: x
  defp list_to_char([x|tail] = list), do: "#{length(list)}#{x}"
end

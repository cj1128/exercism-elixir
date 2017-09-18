defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/\W+/, " ")
    |> String.split
    |> Enum.map(&String.at(&1, 0))
    |> Enum.join("")
  end
end

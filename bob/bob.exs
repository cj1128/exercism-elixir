defmodule Bob do
  def hey(input) do
    cond do
      String.ends_with?(input, "?") ->
        "Sure."
      String.trim(input) == "" ->
        "Fine. Be that way!"
      is_yell(input) ->
        "Whoa, chill out!"
      true -> 
        "Whatever."
    end
  end

  defp is_yell(input) do
    contains_character = 
      input
      |> String.replace(~r/\d/, "")
      |> String.match?(~r/\w+/)
    is_upcase = String.upcase(input) == input
    contains_character and is_upcase
  end
end

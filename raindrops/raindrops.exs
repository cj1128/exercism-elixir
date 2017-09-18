defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    result = 
      [3, 5, 7]
      |> Enum.filter(&(rem(number, &1) == 0))
      |> Enum.map(fn x ->
        cond do
          x == 3 -> "Pling"
          x == 5 -> "Plang"
          x == 7 -> "Plong"
          true -> ""
        end
      end)
      |> Enum.join
    if result == "" do
      to_string(number)
    else
      result
    end
  end
end

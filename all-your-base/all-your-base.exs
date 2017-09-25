defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil
  def convert([], _, _), do: nil
  def convert(digits, base_a, base_b) do
    cond do
      Enum.all?(digits, &(&1 == 0)) -> [0]
      Enum.any?(digits, &(&1 < 0 or &1 >= base_a)) -> nil
      true ->
        digits
        |> to_base10(base_a)
        |> from_base10(base_b)
    end
  end

  def to_base10(digits, base) do
    digits
    |> Enum.reduce(fn x, acc -> acc * base + x end)
  end

  def from_base10(0, _), do: []
  def from_base10(number, base) do
    from_base10(div(number, base), base) ++ [rem(number, base)]
  end
end

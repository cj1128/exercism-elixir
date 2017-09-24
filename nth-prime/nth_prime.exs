defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count <= 0, 
    do: raise ArgumentError, message: "Invalid index, must be > 0"
  def nth(count) do
    prime_stream()
    |> Enum.take(count)
    |> List.last
  end

  defp prime_stream do
    Stream.concat([2], Stream.iterate(3, &(&1 + 2)))
    |> Stream.filter(&is_prime/1)
  end
  
  defp is_prime(number) when number <= 1, do: false
  defp is_prime(number) when number in [2, 3, 5, 7, 11, 13], do: true
  defp is_prime(number) when rem(number, 2) == 0, do: false
  defp is_prime(number) do
    2..trunc(:math.sqrt(number))
    |> Enum.all?(&(rem(number, &1) != 0))
  end
end

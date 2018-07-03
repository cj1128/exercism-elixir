defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number < 1 or number > 64 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end
  def square(number) do
    {:ok, pow(2, number - 1)}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    result =
      1..64
      |> Enum.map(&square/1)
      |> Enum.map(&(elem(&1, 1)))
      |> Enum.sum
    {:ok, result}
  end

  defp pow(base, power) do
    do_pow(base, power, 1)
  end

  defp do_pow(base, 0, result), do: result
  defp do_pow(base, power, result) do
    do_pow(base, power - 1, result * base)
  end
end

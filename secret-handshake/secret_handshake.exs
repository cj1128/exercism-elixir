defmodule SecretHandshake do
  @actions %{0b1 => "wink", 0b10 => "double blink", 0b100 => "close your eyes", 0b1000 => "jump"}
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    result = 
      Map.keys(@actions)
      |> Enum.reverse()
      |> Enum.reduce([], fn x, acc ->
        if bit_set(code, x) do
          [Map.get(@actions, x) | acc]
        else
          acc
        end
      end)

    if bit_set(code, 0b10000) do
      Enum.reverse(result)
    else
      result
    end
  end

  defp bit_set(value, mask) do
    import Bitwise
    (value &&& mask) != 0
  end
end


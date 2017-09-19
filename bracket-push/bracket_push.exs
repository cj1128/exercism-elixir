defmodule BracketPush do
  @brackets %{
    "[" => "]",
    "(" => ")",
    "{" => "}",
  }
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    stack = 
      str
      |> String.graphemes
      |> to_stack([])
    length(stack) == 0
  end

  @doc """
  convert string list to bracket stack
  """
  def to_stack([], stack), do: stack
  def to_stack([x | tail], stack) do
    cond do
      # open bracket
      x in Map.keys(@brackets) ->
        to_stack(tail, [x | stack])
      # close bracket
      x in Map.values(@brackets) ->
        open = Enum.at(stack, 0)
        # bracket match
        if Map.get(@brackets, open) == x do
          to_stack(tail, tl(stack))
        else
          to_stack(tail, [x | stack])
        end
      true ->
        to_stack(tail, stack) 
    end
  end
end

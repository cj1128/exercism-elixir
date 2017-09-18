defmodule Sublist do
  def compare(a, b) do
    len_a = length(a)
    len_b = length(b)
    cond do
      len_a > len_b -> if is_sublist(b, a), do: :superlist, else: :unequal
      len_a == len_b -> if is_sublist(a, b), do: :equal, else: :unequal
      len_a < len_b -> if is_sublist(a, b), do: :sublist, else: :unequal
    end
  end

  def is_sublist([], _), do: true
  def is_sublist(_, []), do: false
  def is_sublist(a, b) do
    if matchhead?(a, b), do: true, else: is_sublist(a, tl(b))
  end

  def matchhead?([], _), do: true
  def matchhead?(_, []), do: false
  def matchhead?(a, b) do
    if hd(a) === hd(b), do: matchhead?(tl(a), tl(b)), else: false
  end
end

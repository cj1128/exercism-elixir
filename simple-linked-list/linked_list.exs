defmodule LinkedList do
  @opaque t :: tuple()
  defstruct [:item, :next]

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    %LinkedList{}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    %LinkedList{item: elem, next: list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    get_length(list, 0)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    list.next == nil
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    if empty?(list) do
      {:error, :empty_list}
    else
      {:ok, list.item}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    if empty?(list) do
      {:error, :empty_list}
    else
      {:ok, list.next}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    if empty?(list) do
      {:error, :empty_list}
    else
      {:ok, list.item, list.next}
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  # the most recent item is on the left
  @spec from_list(list()) :: t
  def from_list([]), do: %LinkedList{}
  def from_list([x | tail]) do
    %LinkedList{
      item: x,
      next: from_list(tail),
    }
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    do_to_list(list, [])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list
    |> to_list
    |> Enum.reverse
    |> from_list
  end

  defp get_length(%LinkedList{next: nil}, length), do: length
  defp get_length(%LinkedList{next: next}, length), do: get_length(next, length + 1)

  # left is the most recent item
  defp do_to_list(%LinkedList{next: nil}, result), do: result
  defp do_to_list(%LinkedList{next: next, item: item}, result), do: do_to_list(next, result ++ [item])
end

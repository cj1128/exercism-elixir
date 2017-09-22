defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    case parse(raw) do
      nil -> "0000000000"
      {area, exchange, subscriber} ->
        area <> exchange <> subscriber
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    case parse(raw) do
      nil -> "000"
      {area, _, _} -> area
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    case parse(raw) do
      nil -> "(000) 000-0000"
      {area, exchange, subscriber} -> "(#{area}) #{exchange}-#{subscriber}"
    end
  end

  # Parse phone number
  # Return a three item tuple {area, exchange, subscriber} if valid,
  # nil otherwise
  # only `1` is considered to be valid country code
  defp parse(raw) do
    regex = ~r/^1?(?<a>[2-9]\d\d)(?<e>[2-9]\d\d)(?<s>\d{4})$/
    with %{"a" => area, "e" => exchange, "s" => subscriber} <- Regex.named_captures(regex, cleanup_input(raw)) do
      {area, exchange, subscriber}
    end
  end

  defp cleanup_input(raw) do
    String.replace(raw, ~r/[(). +\-]/, "")
  end
end

defmodule Tournament do
  @table_header "Team                           | MP |  W |  D |  L |  P"

  defmodule Record do
    defstruct mp: 0, w: 0, d: 0, l: 0, p: 0
  end
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.filter(&(length(&1) == 3))
    |> Enum.filter(&(Enum.at(&1, 2) in ["win", "loss", "draw"]))
    |> Enum.reduce(%{}, fn [t1, t2, result], acc ->
      t1_record = Map.get(acc, t1, %Record{})
      t2_record = Map.get(acc, t2, %Record{})
      acc = Map.put(acc, t1, update_record(t1_record, result))
      Map.put(acc, t2, update_record(t2_record, reverse(result)))
    end)
    |> generate_table
  end

  def generate_table(map) do
    import String, only: [pad_trailing: 2, pad_leading: 2]
    map
    |> Enum.sort_by(fn {name, record} -> {-record.p, name} end)
    |> Enum.reduce(@table_header, fn {name, record}, acc ->
      acc <> "\n" <> Enum.join([
        pad_trailing(name, 30), 
        pad_leading(to_string(record.mp), 2),
        pad_leading(to_string(record.w), 2),
        pad_leading(to_string(record.d), 2),
        pad_leading(to_string(record.l), 2),
        pad_leading(to_string(record.p), 2),
      ], " | ")
    end)
  end

  def update_record(record, "win"), 
    do: %{record | mp: record.mp + 1, w: record.w + 1, p: record.p + 3}
  def update_record(record, "loss"), 
    do: %{record | mp: record.mp + 1, l: record.l + 1}
  def update_record(record, "draw"), 
    do: %{record | mp: record.mp + 1, d: record.d + 1, p: record.p + 1}

  def reverse("win"), do: "loss"
  def reverse("loss"), do: "win"
  def reverse("draw"), do: "draw"
end

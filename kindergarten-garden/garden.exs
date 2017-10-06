defmodule Garden do
  @default_students ~w(
    alice bob charlie
    david eve fred
    ginny harriet ileana
    joseph kincaid larry
  )a

  @plant_mapping %{
    "V" => :violets,
    "R" => :radishes,
    "C" => :clover,
    "G" => :grass,
  }
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_students) do
    plants = 
      info_string
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(fn l -> Enum.map(l, &@plant_mapping[&1]) end)
      |> Enum.map(&Enum.chunk_every(&1, 2))
      |> Enum.zip
      |> Enum.map(fn {[a, b,], [c, d]} -> {a, b, c, d} end)

    student_names
    |> Enum.sort
    |> Enum.with_index
    |> Enum.map(fn {name, index} -> {name, Enum.at(plants, index, {})} end)
    |> Map.new
  end
end

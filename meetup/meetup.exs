defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    {year, month, meetup_day(year, month, weekday, schedule)}
  end

  @weekday_names %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7,
  }

  defp meetup_day(year, month, weekday, schedule) do
    weekday_number = @weekday_names[weekday]

    candidates =
      1..Calendar.ISO.days_in_month(year, month)
      |> Enum.filter(&(Calendar.ISO.day_of_week(year, month, &1) == weekday_number))

    case schedule do
      :first -> Enum.at(candidates, 0)
      :second -> Enum.at(candidates, 1)
      :third -> Enum.at(candidates, 2)
      :fourth -> Enum.at(candidates, 3)
      :last -> Enum.at(candidates, -1)
      :teenth -> Enum.find(candidates, &(&1 > 12))
    end
  end
end

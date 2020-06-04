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

  # What day to start the search on for the nth occurence of a given weekday
  @start_day %{
    first: 1,
    second: 8,
    third: 15,
    fourth: 22,
    teenth: 13,
  }

  # Mapping of named weekdays to their integer day in the week, to match Date.day_of_week/1
  @day_of_week %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7,
  }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, :last) do
    {:ok, dt} = Date.new(year, month, 1)
    last_day = Date.days_in_month(dt)
    find_next_day(year, month, last_day, @day_of_week[weekday], -1)
  end

  def meetup(year, month, weekday, schedule) do
    find_next_day(year, month, @start_day[schedule], @day_of_week[weekday])
  end

  @spec find_next_day(pos_integer, pos_integer, pos_integer, pos_integer, pos_integer) :: Date.t()
  defp find_next_day(year, month, day, day_of_week, step \\ 1) do
    {:ok, dt} = Date.new(year, month, day)

    if Date.day_of_week(dt) == day_of_week do
      dt
    else
      find_next_day(year, month, day + step, day_of_week, step)
    end
  end
end

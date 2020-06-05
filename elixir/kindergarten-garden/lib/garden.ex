defmodule Garden do
  @default_students [
    :alice, :bob, :charlie, :david, :eve, :fred,
    :ginny, :harriet, :ileana, :joseph, :kincaid, :larry
  ]

  @plants %{
    "G" => :grass,
    "C" => :clover,
    "R" => :radishes,
    "V" => :violets,
  }

  @plants_per_student 2

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_students) do
    student_names = Enum.sort(student_names)
    info = Map.new(student_names, fn name -> {name, {}} end)

    info_string
    |> String.split("\n")
    |> Enum.reduce(info, &parse_line(&1, &2, student_names))
  end

  defp parse_line(line, info, student_names) do
    line
    |> String.graphemes()
    |> Enum.chunk_every(@plants_per_student)
    |> Enum.zip(student_names)
    |> Enum.reduce(info, &parse_letters/2)
  end

  defp parse_letters({letters, name}, info) do
    Enum.reduce(letters, info, fn letter, info ->
      Map.put(info, name, Tuple.append(info[name], @plants[letter]))
    end)
  end
end

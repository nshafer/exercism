defmodule TeamRecord do
  defstruct matches: 0, wins: 0, losses: 0, draws: 0, points: 0

  @win_points 3
  @draw_points 1
  @loss_points 0

  def win(%TeamRecord{matches: matches, wins: wins, points: points} = record) do
    %{record | matches: matches + 1, wins: wins + 1, points: points + @win_points}
  end

  def loss(%TeamRecord{matches: matches, losses: losses, points: points} = record) do
    %{record | matches: matches + 1, losses: losses + 1, points: points + @loss_points}
  end

  def draw(%TeamRecord{matches: matches, draws: draws, points: points} = record) do
    %{record | matches: matches + 1, draws: draws + 1, points: points + @draw_points}
  end
end

defmodule Tournament do
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
    |> Stream.filter(&valid_line?/1)
    |> Stream.map(&parse_line/1)
    |> Enum.reduce(%{}, &collate_results/2)
    |> Enum.sort_by(&result_sorter/1)
    |> result()
  end

  def valid_line?(line) do
    String.match?(line, ~r/^[\w\d\s]+;[\w\d\s]+;(?:win|loss|draw)$/u)
  end

  def parse_line(line) do
    line
    |> String.split(";")
    |> List.to_tuple()
  end

  def collate_results({team_a, team_b, result}, results) do
    record_a = Map.get(results, team_a, %TeamRecord{})
    record_b = Map.get(results, team_b, %TeamRecord{})

    {record_a, record_b} =
      case result do
        "win" -> {TeamRecord.win(record_a), TeamRecord.loss(record_b)}
        "loss" -> {TeamRecord.loss(record_a), TeamRecord.win(record_b)}
        "draw" -> {TeamRecord.draw(record_a), TeamRecord.draw(record_b)}
        _ -> {record_a, record_b}
      end

    results = Map.put(results, team_a, record_a)
    results = Map.put(results, team_b, record_b)

    results
  end

  def result_sorter({team, %{points: points}}) do
    {-points, team}
  end

  def result(result_list) do
    "#{result_header()}\n#{result_table(result_list)}"
  end

  def result_header() do
    format_table_row("Team", "MP", "W", "D", "L", "P")
  end

  def result_table(result_list) do
    result_list
    |> Enum.map(&result_table_row/1)
    |> Enum.join("\n")
  end

  def result_table_row({team, record}) do
    format_table_row(team, record.matches, record.wins, record.draws, record.losses, record.points)
  end

  def format_table_row(team, matches, wins, draws, losses, points) do
    "#{String.pad_trailing(team, 30)} | " <>
      "#{String.pad_leading(format_value(matches), 2)} | " <>
      "#{String.pad_leading(format_value(wins), 2)} | " <>
      "#{String.pad_leading(format_value(draws), 2)} | " <>
      "#{String.pad_leading(format_value(losses), 2)} | " <>
      "#{String.pad_leading(format_value(points), 2)}"
  end

  def format_value(value) when is_binary(value), do: value
  def format_value(value) when is_integer(value), do: Integer.to_string(value)
end

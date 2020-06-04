defmodule Matrix do
  # Default to a 3x3 identity matrix. Keys are {row_num, col_num} or {m, n}
  defstruct matrix: %{
    {0, 0} => 1, {0, 1} => 0, {0, 2} => 0,
    {1, 0} => 0, {1, 1} => 1, {1, 2} => 0,
    {2, 0} => 0, {2, 1} => 0, {2, 2} => 1,
  }

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    matrix = input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(&parse_row(&1))
    |> Enum.into(%{})
    %Matrix{matrix: matrix}
  end

  defp parse_row({row, row_num}) do
    row
    |> String.split(" ")
    |> Enum.with_index()
    |> Enum.map(&parse_col(row_num, &1))
  end

  defp parse_col(row_num, {col, col_num}) do
    {{row_num, col_num}, String.to_integer(col)}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    Matrix.rows(matrix)
    |> Enum.map(fn row -> Enum.join(row, " ") end)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    0..2 |> Enum.map(&Matrix.row(matrix, &1))
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    matrix.matrix
    |> Enum.filter(fn {{m, _}, _} -> m == index end)
    |> Enum.map(fn {_, v} -> v end)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    0..2 |> Enum.map(&Matrix.column(matrix, &1))
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix.matrix
    |> Enum.filter(fn {{_, n}, _} -> n == index end)
    |> Enum.map(fn {_, v} -> v end)
  end
end

defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({}, elem), do: {elem, {}}
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list), do: do_length(list, 0)
  defp do_length({}, len), do: len
  defp do_length({_elem, tail}, len), do: do_length(tail, len + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({}), do: true
  def empty?({_elem, _tail}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: {:error, :empty_list}
  def peek({elem, _next}), do: {:ok, elem}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: {:error, :empty_list}
  def tail({_elem, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: {:error, :empty_list}
  def pop({elem, tail}), do: {:ok, elem, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list), do: do_from_list(list, new())
  defp do_from_list([], new_list), do: reverse(new_list)
  defp do_from_list([head | tail], new_list), do: do_from_list(tail, push(new_list, head))

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: do_to_list(list, [])
  defp do_to_list({}, new_list), do: Enum.reverse(new_list)
  defp do_to_list({elem, tail}, new_list), do: do_to_list(tail, [elem | new_list])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list, new())
  defp do_reverse({}, new_list), do: new_list
  defp do_reverse({elem, tail}, new_list), do: do_reverse(tail, push(new_list, elem))
end

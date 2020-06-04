defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: do_count(l, 0)

  defp do_count([], c), do: c
  defp do_count([_ | tail], c), do: do_count(tail, c + 1)

  @spec reverse(list) :: list
  def reverse(l), do: do_reverse(l, [])

  defp do_reverse([], acc), do: acc
  defp do_reverse([head | tail], acc), do: do_reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f, [])

  defp do_map([], _, acc), do: reverse(acc)
  defp do_map([head | tail], f, acc), do: do_map(tail, f, [f.(head) | acc])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f, [])

  defp do_filter([], _, acc), do: reverse(acc)
  defp do_filter([head | tail], f, acc) do
    case f.(head) do
      true -> do_filter(tail, f, [head | acc])
      false -> do_filter(tail, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append(a, b), do: do_append(a, b, [])

  defp do_append([], [], acc), do: reverse(acc)
  defp do_append([], [head | tail], acc), do: do_append([], tail, [head | acc])
  defp do_append([head | tail], b, acc), do: do_append(tail, b, [head | acc])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: do_concat(ll, [])

  defp do_concat([], acc), do: reverse(acc)
  defp do_concat([[] | tail], acc), do: do_concat(tail, acc)
  defp do_concat([[h | t] | tail], acc), do: do_concat([t | tail], [h | acc])
end

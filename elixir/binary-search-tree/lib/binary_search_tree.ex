defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data), do: new(data)
  def insert(tree, data) do
    if data <= tree.data do
      %{tree | left: insert(tree.left, data)}
    else
      %{tree | right: insert(tree.right, data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []
  def in_order(%{data: d, left: nil, right: nil}), do: [d]
  def in_order(%{data: d, left: nil, right: r}), do: [d] ++ in_order(r)
  def in_order(%{data: d, left: l, right: nil}), do: in_order(l) ++ [d]
  def in_order(%{data: d, left: l, right: r}), do: in_order(l) ++ [d] ++ in_order(r)
end

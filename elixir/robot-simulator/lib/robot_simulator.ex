defmodule Robot do
  defstruct position: nil, direction: nil
end

defmodule RobotSimulator do
  defguardp is_direction(dir) when is_atom(dir) and dir in [:north, :east, :south, :west]
  defguardp is_position(position) when is_tuple(position) and tuple_size(position) == 2
  defguardp is_position(x, y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, {x, y} = position) when is_direction(direction) and is_position(x, y) do
    %Robot{direction: direction, position: position}
  end

  def create(direction, _) when not is_direction(direction), do: {:error, "invalid direction"}
  def create(_, position) when not is_position(position), do: {:error, "invalid position"}
  def create(_, {x, y}) when not is_position(x, y), do: {:error, "invalid position"}
  def create(_, _), do: {:error, "invalid arguments"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.graphemes(instructions)
    |> Enum.reduce_while(robot, &do_step/2)
  end

  defp do_step("A", %Robot{direction: direction, position: {x, y}} = robot) do
    new_position = case direction do
      :north -> {x, y + 1}
      :south -> {x, y - 1}
      :east -> {x + 1, y}
      :west -> {x - 1, y}
    end
    {:cont, %Robot{robot | position: new_position}}
  end

  defp do_step("R", %Robot{direction: direction} = robot) do
    new_direction = case direction do
      :north -> :east
      :south -> :west
      :east -> :south
      :west -> :north
    end
    {:cont, %Robot{robot | direction: new_direction}}
  end

  defp do_step("L", %Robot{direction: direction} = robot) do
    new_direction = case direction do
      :north -> :west
      :south -> :east
      :east -> :north
      :west -> :south
    end
    {:cont, %Robot{robot | direction: new_direction}}
  end

  defp do_step(_, _), do: {:halt, {:error, "invalid instruction"}}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%Robot{direction: direction}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%Robot{position: position}), do: position
end

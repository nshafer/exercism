defmodule Phone do
  defstruct country: "0", area: "000", exchange: "000", subscriber: "0000"

  def new(raw) when is_binary(raw) do
    Regex.named_captures(~r/\+?(?<country>\d*)?.*(?<area>[2-9]\d{2}).*(?<exchange>[2-9]\d{2}).*(?<subscriber>\d{4})/, raw)
    |> new()
  end

  def new(%{"country" => country, "area" => area, "exchange" => exchange, "subscriber" => subscriber})
      when country == "" or country == "1" do
    %Phone{country: "1", area: area, exchange: exchange, subscriber: subscriber}
  end

  def new(_), do: %Phone{}

  def print(%Phone{area: area, exchange: exchange, subscriber: subscriber}) do
    area <> exchange <> subscriber
  end

  @spec number(String.t()) :: String.t()
  def number(raw) do
    raw
    |> new()
    |> print()
  end

  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw
    |> new()
    |> Map.get(:area)
  end

  def pretty(%Phone{area: area, exchange: exchange, subscriber: subscriber}) do
    "(#{area}) #{exchange}-#{subscriber}"
  end

  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    raw
    |> new()
    |> pretty()
  end
end

defmodule CoffeeGrinder do
  def grind(bean) when is_map(bean) do
    %{bean | consistency: :ground}
  end

  def grind(beans) when is_list(beans) do
    beans
    |> Enum.map(&(Task.async(fn -> %{&1 | consistency: :ground} end)))
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(%{}, &Map.merge/2)
  end
end

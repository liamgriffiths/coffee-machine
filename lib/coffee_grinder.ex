defmodule CoffeeGrinder do
  # TODO not sure how to type these

  # @spec grind(CoffeeJar.Bean.t) :: Task.t
  def grind(bean = %CoffeeJar.Bean{}) do
    Task.async(fn ->
      %{bean | consistency: Enum.random([:course, :fine])}
    end)
  end

  # @spec grind([CoffeeJar.Bean.t()]) :: Result.t(CoffeeJar.Bean.t())
  def grind(beans) do
    grounds = beans |> Enum.map(&grind/1) |> Enum.map(&Task.await/1)
    {:ok, grounds}
  end
end

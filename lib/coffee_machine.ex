defmodule CoffeeMachine do
  defmodule Covfefe do
    defstruct [:quality]
    @type t :: %Covfefe{quality: quality}
    @type t(quality) :: %Covfefe{quality: quality}
    @type quality :: :bleh | :drinkable | :lit
  end

  def fresh_pot! do
    res =
      with {:ok, grounds, water, milk} <- get_ingredients() |> Task.await(),
           {:ok, steamed_milk} <- steam_milk(milk) |> Task.await(),
           {:ok, coffee} <- brew_coffee(grounds, water) |> Task.await(),
           do: {:ok, coffee, steamed_milk}

    case res do
      {:ok, combined} ->
        # measure coffee amount
        # measure water purity && temp
        # check if milk is steamed
        %Covfefe{quality: :drinkable}

      err -> err
    end
  end

  @spec get_ingredients() :: Task.t()
  def get_ingredients do
    Task.async(fn ->
      with {:ok, _} <- CoffeeJar.grab(),
           {:ok, beans} <- CoffeeJar.take(10),
           {:ok, grounds} <- CoffeeGrinder.grind(beans),
           {:ok, milk} <- DairyFarm.order_milk(1),
           {:ok, _} <- WaterFaucet.on(),
           {:ok, water} <- WaterFaucet.take(1),
           {:ok, _} <- WaterFaucet.off(),
           do: {:ok, {grounds, water, milk}}
    end)
  end

  @spec heat_water(WaterFaucet.Water.t()) :: Task.t()
  def heat_water(water) do
    Task.async(fn ->
      {:ok, %{water | temp: water.temp * 10}}
    end)
  end

  @spec steam_milk(DairyFarm.Milk.t()) :: Task.t()
  def steam_milk(milk) do
    Task.async(fn -> {:ok, %{milk | consistency: :steamy}} end)
  end

  @spec brew_coffee([CoffeeJar.Bean.t()], [WaterFaucet.Water.t()]) :: Task.t()
  def brew_coffee(grounds, water) do
    Task.async(fn ->
      hot_water = heat_water(water) |> Task.await()
      coffee_filter = &Enum.filter(&1, fn b -> b.consistency == :ground end)
      {:ok, {hot_water, coffee_filter.(grounds)}}
    end)
  end
end

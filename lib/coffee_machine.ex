defmodule CoffeeMachine do
  # use Application
  #
  #
  # defmodule BrewedCoffee do
  #   defstruct [:beans, :water, :care]
  #   @type t :: %BrewedCoffee{beans: Beans.t, water: Water.t, care: number | nil}
  #   @type t(beans, water, care) :: %BrewedCoffee{beans: beans, water: water, care: care}
  # end
  #
  # defmodule Covfefe do
  #   defstruct [:quality]
  #   @type t :: %Covfefe{quality: quality}
  #   @type t(consistency) :: %Covfefe{quality: consistency}
  #   @type quality :: :bleh | :drinkable | :lit
  # end
  #
  # # Callback to the run the machine
  # def start(_type, _args) do
  #   # IO.puts "Starting up!"
  #   # task = Task.async(fn -> CoffeeMachine.run() end)
  #   # Task.await(task) |> IO.inspect
  #   # System.stop(0)
  # end
  #
  # @spec run() :: Result.t(Covfefe.t)
  # def run do
  #   covfefe =
  #     with {:ok, milk} <- get_milk(),
  #          {:ok, water} <- get_water(),
  #          {:ok, beans} <- get_beans(),
  #          {:ok, pure_water} <- purify_water(water),
  #          {:ok, hot_water} <- heat_water(pure_water),
  #          {:ok, grounds} <- grind_beans(beans),
  #          {:ok, mood} <- get_mood(),
  #          {:ok, brewed_coffee} <- brew(hot_water, grounds, mood),
  #          {:ok, steamed_milk} <- steam_milk(milk),
  #          {:ok, quality} <- make_covfefe(brewed_coffee, steamed_milk),
  #       do: {:ok, %Covfefe{quality: quality}}
  #   covfefe
  # end
  #
  # @spec make_covfefe(BrewedCoffee.t, Milk.t) :: Result.t(Covfefe.quality)
  # def make_covfefe(brew, milk) do
  #   case milk.consistency do
  #     :steamy -> cond do
  #       brew.water.pure == false -> {:ok, :bleh}
  #       brew.care < 10 -> {:ok, :bleh}
  #       brew.care <= 20 -> {:ok, :drinkable}
  #       brew.care > 20 -> {:ok, :lit}
  #     end
  #     _ -> {:error, "You can't add unsteamed milk!"}
  #   end
  # end
  #
  # @spec purify_water(Water.t) :: Result.t(Water.pure)
  # def purify_water(water) do
  #   {:ok, %{water | pure: true}}
  # end
  #
  # @spec heat_water(Water.t) :: Result.t(Water.t)
  # def heat_water(water) do
  #   {:ok, %{water | temp: water.temp * 10 }}
  # end
  #
  # @spec grind_beans(Beans.t) :: Result.t(Beans.ground)
  # def grind_beans(beans) do
  #   case beans.consistency do
  #     :whole -> {:ok, %{beans | consistency: :ground}}
  #     :ground -> {:error, "You already ground the beans!"}
  #   end
  # end
  #
  # @spec brew(Water.t, Beans.t, number | nil) :: Result.t(BrewedCoffee.t)
  # def brew(water, beans, care) do
  #   cond do
  #     is_nil(care) -> {:error, "Not a care in the world..."}
  #     water.temp < 91 -> {:error, "You didn't heat the water enough!"}
  #     true -> {:ok, %BrewedCoffee{water: water, beans: beans, care: care}}
  #   end
  # end
  #
  # @spec steam_milk(Milk.t) :: Result.t(Milk.t)
  # def steam_milk(milk) do
  #   {:ok, %{milk | consistency: :steamy}}
  # end
end

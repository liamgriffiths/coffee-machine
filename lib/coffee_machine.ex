defmodule CoffeeMachine do
  defmodule Water do
    defstruct [:pure, :temp]
    @type t :: %Water{pure: boolean, temp: number}
    @type t(pure, temp) :: %Water{pure: pure, temp: temp}
    @type pure :: t(true, number)
  end

  defmodule Beans do
    defstruct [:consistency]
    @type t :: %Beans{consistency: :whole | :ground}
    @type t(consistency) :: %Beans{consistency: consistency}
    @type ground :: t(:ground)
  end

  defmodule BrewedCoffee do
    defstruct [:beans, :water, :care]
    @type t :: %BrewedCoffee{beans: Beans.t, water: Water.t, care: number | nil}
    @type t(beans, water, care) :: %BrewedCoffee{beans: beans, water: water, care: care}
  end

  defmodule Milk do
    defstruct [:consistency]
    @type t :: %Milk{consistency: :liquid | :steamy}
    @type t(consistency) :: %Milk{consistency: consistency}
  end

  defmodule Covfefe do
    defstruct [:quality]
    @type t :: %Covfefe{quality: :bleh | :drinkable | :lit }
    @type t(consistency) :: %Covfefe{quality: consistency}
  end

  defmodule Result do
    @type t :: {:ok, struct()} | {:error, String.t}
    @type t(result) :: {:ok, result} | {:error, String.t}
  end

  @spec run() :: Result.t(Covfefe.t)
  def run do
    water = %Water{pure: true, temp: :rand.uniform(30)}
    beans = %Beans{consistency: :whole}
    milk = %Milk{consistency: :liquid}

    case purify_water(water) do
      {:ok, pure_water} ->
        case heat_water(pure_water) do
          {:ok, hot_water} ->
            case grind_beans(beans) do
              {:ok, grounds} ->
                case brew(hot_water, grounds, :rand.uniform(60)) do
                  {:ok, brewed} ->
                    case steam_milk(milk) do
                      {:ok, foam} ->
                        cond do
                          brewed.care > 10 && foam.consistency == :steamy ->
                            {:ok, %Covfefe{quality: :drinkable}}
                          brewed.care > 50 && foam.consistency == :steamy ->
                            {:ok, %Covfefe{quality: :lit}}
                          brewed.care <= 10 ->
                            {:ok, %Covfefe{quality: :bleh}}
                        end
                    end
                end
            end
        end
    end
  end

  @spec purify_water(Water.t) :: Result.t(Water.pure)
  def purify_water(water) do
    {:ok, %{water | pure: true}}
  end

  @spec heat_water(Water.t) :: Result.t(Water.t)
  def heat_water(water) do
    {:ok, %{water | temp: water.temp * 10 }}
  end

  @spec grind_beans(Beans.t) :: Result.t(Beans.ground)
  def grind_beans(beans) do
    case beans.consistency do
      :whole -> {:ok, %{beans | consistency: :ground}}
      :ground -> {:error, "Already ground up!"}
    end
  end

  @spec brew(Water.t, Beans.t, number | nil) :: Result.t(BrewedCoffee.t)
  def brew(water, beans, care) do
    cond do
      is_nil(care) -> {:error, "Not a care in the world..."}
      true -> {:ok, %BrewedCoffee{water: water, beans: beans, care: care}}
    end
  end

  @spec steam_milk(Milk.t) :: Result.t(Milk.t)
  def steam_milk(milk) do
    {:ok, %{milk | consistency: :steamy}}
  end
end

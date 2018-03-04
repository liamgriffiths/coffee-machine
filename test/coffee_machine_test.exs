defmodule CoffeeMachineTest do
  use ExUnit.Case
  doctest CoffeeMachine

  describe "CoffeeMachine.purify_water" do
    test "when the water is dirty, it becomes pure" do
      water = %CoffeeMachine.Water{pure: false}
      {:ok, purified} = CoffeeMachine.purify_water(water)
      assert purified.pure == true
    end
  end
end

defmodule DairyFarm do
  defmodule Milk do
    defstruct [:consistency]
    @type t :: %Milk{consistency: :liquid | :steamy}
    @type t(consistency) :: %Milk{consistency: consistency}
  end

  def order_milk(amount) do
    milk = Stream.repeatedly(&milk_cow/0)
           |> Enum.take(amount)
           |> Enum.map(&Task.await/1)
    {:ok, milk}
  end

  @spec milk_cow() :: Task.t
  def milk_cow do
    Task.async(fn ->
      case Enum.random([:moo, :boo]) do
        :moo -> %Milk{consistency: :liquid}
        :boo -> milk_cow() |> Task.await()
      end
    end)
  end
end

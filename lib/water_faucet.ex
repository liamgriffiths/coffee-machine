defmodule WaterFaucet do
  @faucet :faucet

  defmodule Water do
    defstruct [:purity, :temp]
    @type t :: %Water{purity: integer, temp: integer}
    @type t(purity, temp) :: %Water{purity: purity, temp: temp}
  end

  @spec on() :: Result.t(pid)
  def on do
    stream = Stream.repeatedly(&drip/0)
    Agent.start(fn -> stream end, name: @faucet)
  end

  @spec off() :: {:ok, boolean}
  def off do
    {:ok, on?() && Process.whereis(@faucet) |> Process.exit(:kill)}
  end

  @spec on?() :: boolean
  def on? do
    !is_nil(Process.whereis(@faucet))
  end

  @spec take(integer) :: Result.t([Water.t()])
  def take(amount) do
    case on?() do
      true -> {:ok, Agent.get(@faucet, &(&1 |> Enum.take(amount)))}
      false -> {:ok, []}
    end
  end

  @spec drip() :: Water.t()
  defp drip do
    %Water{purity: Enum.random(1..100), temp: Enum.random(12..22)}
  end
end

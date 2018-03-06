defmodule WaterFaucet do
  @faucet :faucet

  defmodule Water do
    defstruct [:purity, :temp]
    @type t :: %Water{purity: number, temp: number}
    @type t(purity, temp) :: %Water{purity: purity, temp: temp}
  end

  def on do
    stream = Stream.repeatedly(&drip/0)
    Agent.start(fn -> stream end, name: @faucet)
  end

  def off do
    on?() && Process.whereis(@faucet) |> Process.exit(:kill)
  end

  def off? do
    is_nil(Process.whereis(@faucet))
  end

  def on? do
    !off?()
  end

  def take(amount) do
    water = on?() && Agent.get(@faucet, &(&1 |> Enum.take(amount)))
    {:ok, water || []}
  end

  defp rand(n) do
    :rand.uniform(n) |> Kernel.trunc()
  end

  defp drip do
    %Water{purity: rand(100), temp: rand(20)}
  end
end

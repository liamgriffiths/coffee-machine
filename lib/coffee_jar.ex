defmodule CoffeeJar do
  @jar :jar

  defmodule Bean do
    defstruct [:consistency]
    @type t :: %Bean{consistency: :whole | :course | :fine}
    @type t(consistency) :: %Bean{consistency: consistency}
    @type ground :: t(:ground)
  end

  @spec grab() :: Result.t(pid)
  def grab do
    jar = Process.whereis(@jar)

    if is_nil(jar) do
      Agent.start(&more_beans/0, name: @jar)
    else
      {:ok, jar}
    end
  end

  @spec refill() :: Result.t()
  def refill do
    {Agent.update(@jar, &(&1 ++ more_beans()))}
  end

  @spec amount() :: Result.t(integer)
  def amount do
    {:ok, Agent.get(@jar, &length/1)}
  end

  @spec take(integer) :: Result.t([Bean.t()])
  def take(amount) do
    case Agent.get(@jar, &Enum.take(&1, amount)) do
      [] ->
        {:error, "We ran out of beans!"}

      beans when length(beans) > 0 ->
        Agent.update(@jar, &Enum.drop(&1, amount))
        {:ok, beans}
    end
  end

  @spec more_beans() :: [Bean.t()]
  defp more_beans do
    %Bean{consistency: :whole} |> List.duplicate(100)
  end
end

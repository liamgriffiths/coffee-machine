defmodule CoffeeJar do
  @jar :jar

  defmodule Bean do
    defstruct [:consistency]
    @type t :: %Bean{consistency: :whole | :ground}
    @type t(consistency) :: %Bean{consistency: consistency}
    @type ground :: t(:ground)
  end

  def grab do
    Agent.start(&more_beans/0, name: @jar)
  end

  def refill do
    {Agent.update(@jar, &(&1 ++ more_beans()))}
  end

  def amount do
    {:ok, Agent.get(@jar, &length/1)}
  end

  def take(amount) do
    case Agent.get(@jar, &Enum.take(&1, amount)) do
      [] ->
        {:error, "We ran out of beans!"}

      beans when length(beans) > 0 ->
        Agent.update(@jar, &Enum.drop(&1, amount))
        {:ok, beans}
    end
  end

  defp more_beans do
    %Bean{consistency: :whole} |> List.duplicate(100)
  end
end

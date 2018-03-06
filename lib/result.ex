defmodule Result do
  @type t :: {:ok, any} | {:error, String.t()}
  @type t(value) :: {:ok, value} | {:error, String.t()}
end

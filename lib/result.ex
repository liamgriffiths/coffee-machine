defmodule Result do
  @type t :: {:ok} | {:ok, any} | {:error} | {:error, any}
  @type t(value) :: {:ok, value} | {:error, any}
  @type t(value, error) :: {:ok, value} | {:error, error}
end

defmodule Ectonum do
  @moduledoc """
  Implements a custom Ecto type for enumerated values
  """
  defmacro defenum(module, values) when is_list(values) do
    quote do

      defmodule unquote(module) do
        @behaviour Ecto.Type

        def type, do: :string

        def cast(term) do
          Ectonum.cast(term, __valid_values__)
        end

        def load(term), do: Ectonum.load(term)
        def dump(term), do: Ectonum.dump(term)

        defp __valid_values__, do: unquote(values)
      end

    end
  end

  @spec cast(any, list) :: {:ok, atom} | :error
  def cast(value, values) when is_atom(value) do
    if value in values, do: {:ok, value}, else: :error
  end

  def cast(value, values) when is_binary(value) do
    atom = String.to_atom(value)
    if atom in values, do: {:ok, atom}, else: :error
  end

  def cast(_, _), do: :error

  def load(string) when is_binary(string), do: {:ok, String.to_atom(string)}
  def load(_), do: :error

  def dump(value) when is_binary(value), do: {:ok, value}
  def dump(value) when is_atom(value), do: {:ok, Atom.to_string(value)}
  def dump(_), do: :error


end
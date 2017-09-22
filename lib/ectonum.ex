defmodule Ectonum do
  @moduledoc """
  Adds a `defenum/2` macro for defining enum types for Ecto schemas.
  """

  @doc """
  Defines a custom `Ecto.Type` for enumerated fields.

  ## Usage

      defmodule Profile do
        import Ectonum

        defenum GenderEnum, [:male, :female]

        schema "profiles" do
          field :gender, GenderEnum
        end
      end

  In the above example the `:gender` field will cast both string and atom values matching any of the options specified in the enum type.
  """
  defmacro defenum(module, values) when is_list(values) do
    quote do
      defmodule unquote(module) do
        @behaviour Ecto.Type

        def type, do: :string
        def cast(term), do: Ectonum.cast(term, __valid_values__())
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

  @doc false
  def cast(value, values) when is_binary(value) do
    atom = String.to_atom(value)
    if atom in values, do: {:ok, atom}, else: :error
  end

  def cast(_, _), do: :error

  @doc false
  def load(string) when is_binary(string), do: {:ok, String.to_atom(string)}
  def load(_), do: :error

  @doc false
  def dump(value) when is_binary(value), do: {:ok, value}
  def dump(value) when is_atom(value), do: {:ok, Atom.to_string(value)}
  def dump(_), do: :error


end

defmodule EctonumTest do
  use ExUnit.Case
  doctest Ectonum

  describe "cast/2" do
    test "it casts string values" do
      assert {:ok, :<} == Ectonum.cast("<", [:<])
    end

    test "it casts atom values" do
      assert {:ok, :<} == Ectonum.cast(:<, [:<])
    end
  end
end

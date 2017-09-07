defmodule Workshop.BadwordTest do
  use Workshop.ModelCase

  alias Workshop.Badword

  @valid_attrs %{palabra: "some palabra"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Badword.changeset(%Badword{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Badword.changeset(%Badword{}, @invalid_attrs)
    refute changeset.valid?
  end
end

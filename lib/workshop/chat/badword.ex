defmodule Workshop.Chat.Badword do
  use Ecto.Schema
  import Ecto.Changeset
  alias Workshop.Chat.Badword


  schema "badwords" do
    field :palabra, :string

    timestamps()
  end

  @doc false
  def changeset(%Badword{} = badword, attrs) do
    badword
    |> cast(attrs, [:palabra])
    |> validate_required([:palabra])
  end



end
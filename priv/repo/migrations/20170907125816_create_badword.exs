defmodule Workshop.Repo.Migrations.CreateBadword do
  use Ecto.Migration

  def change do
    create table(:badwords) do
      add :palabra, :string

      timestamps()
    end
  end
end

defmodule Workshop.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:badwords) do
      add :palabra, :string

      timestamps()
    end

  end
end

defmodule Moments.Repo.Migrations.CreateMoments do
  use Ecto.Migration

  def change do
    create table(:moments) do
      add :type, :string
      add :price, :float
      add :entry, :text

      timestamps()
    end

  end
end

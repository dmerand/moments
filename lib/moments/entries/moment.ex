defmodule Moments.Entries.Moment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "moments" do
    field :entry, :string
    field :price, :float
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(moment, attrs) do
    moment
    |> cast(attrs, [:type, :price, :entry])
    |> validate_required([:type, :price, :entry])
  end
end

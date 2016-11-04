defmodule EctoTuplesExample.People do
  use EctoTuplesExample.Web, :model

  schema "people" do
    field :first_name, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name])
    |> validate_required([:first_name])
  end
end

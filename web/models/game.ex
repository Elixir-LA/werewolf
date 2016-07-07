defmodule Werewolf.Game do
  use Werewolf.Web, :model

  schema "games" do
    field :slug, :string

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w(slug)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

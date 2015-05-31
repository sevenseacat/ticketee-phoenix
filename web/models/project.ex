defmodule Ticketee.Project do
  use Ticketee.Web, :model

  schema "projects" do
    field :title, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(title description)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

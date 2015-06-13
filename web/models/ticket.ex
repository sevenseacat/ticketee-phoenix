defmodule Ticketee.Ticket do
  use Ticketee.Web, :model

  schema "tickets" do
    field :title, :string
    field :description, :string

    belongs_to :project, Ticketee.Project

    timestamps
  end

  @required_fields ~w(title description project_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:description, min: 10)
  end
end

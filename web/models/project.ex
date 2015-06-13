defmodule Ticketee.Project do
  use Ticketee.Web, :model

  schema "projects" do
    field :title, :string
    field :description, :string
    has_many :tickets, Ticketee.Ticket

    timestamps
  end

  after_delete :remove_tickets

  @required_fields ~w(title)
  @optional_fields ~w(description)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  defp remove_tickets(changeset) do
    Ticketee.Repo.delete_all assoc(changeset.model, :tickets)
    changeset
  end
end

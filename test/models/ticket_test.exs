defmodule Ticketee.TicketTest do
  use Ticketee.ModelCase
  alias Ticketee.Ticket

  @valid_attrs %{description: "some content", title: "some content", project_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "description must be longer than 10 characters" do
    changeset = Ticket.changeset(%Ticket{}, %{description: "aaaaaaaaa"})
    assert changeset.errors[:description]
  end
end

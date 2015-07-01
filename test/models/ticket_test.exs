defmodule Ticketee.TicketTest do
  use Ticketee.ModelCase
  alias Ticketee.Ticket

  test "description must be longer than 10 characters" do
    changeset = Ticket.changeset(%Ticket{}, %{description: "aaaaaaaaa"})
    assert changeset.errors[:description]
  end
end

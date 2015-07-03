defmodule Ticketee.DeleteTickets do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo
    ticket = Forge.saved_ticket Ticketee.Repo, project_id: project.id

    navigate_to ticket_path(conn(), :show, ticket)

    :ok
  end

  test "Users can delete projects" do
    find_element(:link_text, "Delete Ticket") |> click

    assert visible_text({:class, "alert-success"}) == "Ticket deleted successfully."
  end
end

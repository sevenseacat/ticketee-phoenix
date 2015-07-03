defmodule Ticketee.EditTicket do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo
    ticket = Forge.saved_ticket Ticketee.Repo, project_id: project.id

    navigate_to ticket_path(conn(), :show, ticket)
    find_element(:link_text, "Edit Ticket") |> click

    :ok
  end

  test "Users can edit existing tickets with valid attributes" do
    find_element(:name, "ticket[title]") |> fill_field "Make it really shiny!"
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-success"}) == "Ticket updated successfully."
    assert String.contains? visible_text({:tag, "h1"}), "Make it really shiny!"
  end

  test "with invalid attributes" do
    find_element(:name, "ticket[title]") |> fill_field ""
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-danger"}) == "Ticket could not be updated."
  end
end

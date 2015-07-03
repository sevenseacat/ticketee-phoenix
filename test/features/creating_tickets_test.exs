defmodule Ticketee.CreateTickets do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo, title: "Internet Explorer"

    navigate_to project_path(conn(), :show, project)
    find_element(:link_text, "New Ticket") |> click

    :ok
  end

  test "Users can create tickets with valid attributes" do
    find_element(:name, "ticket[title]") |> fill_field "Non-standards compliance"
    find_element(:name, "ticket[description]") |> fill_field "My pages are ugly!"
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-success"}) == "Ticket created successfully."
  end

  test "when providing invalid attributes" do
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-danger"}) == "Ticket could not be created."
    assert String.contains?(visible_text({:class, "has-error"}), "can't be blank")
  end
end

defmodule Ticketee.ViewTicket do
  use Ticketee.FeatureCase

  setup do
    sublime = Forge.saved_project Ticketee.Repo, title: "Sublime Text 3"
    Forge.saved_ticket Ticketee.Repo, project_id: sublime.id, title: "Make it shiny!",
      description: "Gradients! Starbursts! Oh my!"

    ie = Forge.saved_project Ticketee.Repo, title: "Internet Explorer"
    Forge.saved_ticket Ticketee.Repo, project_id: ie.id, title: "Standards compliance",
      description: "Isn't a joke."

    navigate_to project_path(conn(), :index)

    :ok
  end

  test "Users can view tickets for a given project" do
    find_element(:link_text, "Sublime Text 3") |> click

    assert find_element(:link_text, "Make it shiny!")
    assert find_all_elements(:link_text, "Standards compliance") == []

    find_element(:link_text, "Make it shiny!") |> click
    assert String.contains? visible_text({:tag, "h1"}), "Make it shiny!"
    assert visible_on_page? "Gradients! Starbursts! Oh my!"
  end
end

defmodule Ticketee.EditProject do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo, title: "Sublime Text 3"

    navigate_to project_path(conn(), :show, project)
    find_element(:link_text, "Edit Project") |> click

    {:ok, project: project}
  end

  test "Users can edit existing projects" do
    find_element(:name, "project[title]") |> fill_field "Sublime Text 4 beta"
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-success"}) == "Project updated successfully."
    assert visible_text({:tag, "h1"}) == "Sublime Text 4 beta"
  end

  test "when providing invalid attributes" do
    find_element(:name, "project[title]") |> fill_field ""
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-danger"}) == "Project could not be updated."
  end
end

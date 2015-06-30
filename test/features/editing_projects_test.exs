defmodule Ticketee.EditProject do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo, title: "Sublime Text 3"
    {:ok, project: project}
  end

  test "Users can edit existing projects", context do
    navigate_to project_path(conn(), :show, context[:project])

    find_element(:link_text, "Edit Project") |> click
    find_element(:name, "project[title]") |> fill_field "Sublime Text 4 beta"
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-success"}) == "Project updated successfully."
    assert visible_text({:tag, "h1"}) == "Sublime Text 4 beta"
  end
end

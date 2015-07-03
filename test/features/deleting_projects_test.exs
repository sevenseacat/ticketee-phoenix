defmodule Ticketee.DeleteProjects do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo, title: "Sublime Text 3"
    navigate_to project_path(conn(), :show, project)

    :ok
  end

  test "Users can delete projects" do
    find_element(:link_text, "Delete Project") |> click

    assert visible_text({:class, "alert-success"}) == "Project deleted successfully."
    assert find_all_elements(:link_text, "Sublime Text 3") == []
  end
end

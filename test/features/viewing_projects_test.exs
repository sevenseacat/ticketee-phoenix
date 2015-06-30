defmodule Ticketee.ViewProject do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo, title: "Sublime Text 3"
    {:ok, project: project}
  end

  test "Users can view projects" do
    navigate_to "/"
    find_element(:link_text, "Sublime Text 3") |> click

    assert visible_text({:tag, "h1"}) == "Sublime Text 3"
  end
end

defmodule Ticketee.ViewProject do
  use Ticketee.FeatureCase

  setup do
    project = Forge.saved_project Ticketee.Repo, title: "Sublime Text 3"
    {:ok, project: project}
  end

  test "Users can view projects", context do
    navigate_to "/"
    find_element(:link_text, context[:project].title) |> click

    assert find_element(:tag, "h1") |> visible_text == context[:project].title
  end
end

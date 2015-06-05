defmodule Ticketee.CreateProject do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "Users can create new projects" do
    navigate_to "/"

    find_element(:link_text, "New Project") |> click
    find_element(:label, "Name") |> fill_field "Sublime Text 3"
    find_element(:label, "Description") |> fill_field "A text editor for everyone"
    find_element(:text, "Create Project") |> submit_element

    assert page_source, "Project has been created."
  end
end

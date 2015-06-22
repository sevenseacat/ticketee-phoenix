defmodule Ticketee.CreateProject do
  use Ticketee.FeatureCase

  test "Users can create new projects" do
    navigate_to "/"

    # The commented lines are the syntax I would like to have... eventually.
    #link(content: "New Project") |> click
    find_element(:link_text, "New Project") |> click

    #input(label: "Name") |> fill_in "Sublime Text 3"
    find_element(:name, "project[title]") |> fill_field "Sublime Text 3"

    #input(label: "Description") |> fill_in "A text editor for everyone"
    find_element(:name, "project[description]") |> fill_field "A text editor for everyone"

    #button(content: "Create Project") |> submit_element
    find_element(:class, "submit") |> submit_element

    #assert element(class: "flash", content: "Project has been created.")
    assert visible_text({:class, "alert-success"}) == "Project created successfully."
  end
end

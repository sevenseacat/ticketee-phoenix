defmodule Ticketee.CreateProject do
  use Ticketee.FeatureCase

  setup do
    navigate_to project_path(conn(), :index)
    find_element(:link_text, "New Project") |> click

    :ok
  end

  test "Users can create new projects with valid attributes" do
    find_element(:name, "project[title]") |> fill_field "Sublime Text 3"
    find_element(:name, "project[description]") |> fill_field "A text editor for everyone"
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-success"}) == "Project created successfully."
  end

  test "when providing invalid attributes" do
    find_element(:class, "submit") |> submit_element

    assert visible_text({:class, "alert-danger"}) == "Project could not be created."
    assert String.contains?(visible_text({:class, "has-error"}), "can't be blank")
  end

  # This is the syntax I would like to have... eventually.
  # test "Users can create new projects" do
    # navigate_to "/"

    # link(content: "New Project") |> click
    # input(label: "Name") |> fill_in "Sublime Text 3"
    # input(label: "Description") |> fill_in "A text editor for everyone"
    # button(content: "Create Project") |> submit_element

    # assert element(class: "flash", content: "Project has been created.")
  # end
end

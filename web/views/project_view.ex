defmodule Ticketee.ProjectView do
  use Ticketee.Web, :view

  def page_title(:show, assigns), do: assigns[:project].title
  def page_title(action, _) when action in [:new, :create], do: "Create Project"
  def page_title(action, _) when action in [:edit, :update], do: "Edit Project"
  def page_title(_, _),           do: "Projects"
end

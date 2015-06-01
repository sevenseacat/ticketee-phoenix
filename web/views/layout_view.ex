defmodule Ticketee.LayoutView do
  use Ticketee.Web, :view

  def page_title(conn, assigns) do
    try do
      apply(view_module(conn), :page_title, [action_name(conn), assigns]) <> " | " <> default_page_title(conn, assigns)
    rescue
      UndefinedFunctionError -> default_page_title(conn, assigns)
    end
  end

  def default_page_title(_conn, _assigns) do
    "Ticketee"
  end
end

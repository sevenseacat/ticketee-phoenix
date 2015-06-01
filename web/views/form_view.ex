defmodule Ticketee.FormView do
  import Phoenix.HTML.Tag

  def error(f, field, opts \\ []) do
    if f.errors[field] do
      content_tag :div, opts do
        content_tag :p, class: "help-block" do
          f.errors[field]
        end
      end
    end
  end
end
